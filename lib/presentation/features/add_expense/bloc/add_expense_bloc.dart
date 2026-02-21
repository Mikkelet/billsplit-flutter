import 'dart:async';

import 'package:billsplit_flutter/data/local/preferences/shared_prefs.dart';
import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/scanned_receipt_item.dart';
import 'package:billsplit_flutter/domain/models/shared_expense.dart';
import 'package:billsplit_flutter/domain/models/surcharge.dart';
import 'package:billsplit_flutter/domain/use_cases/events/add_event_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/events/delete_expense_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/events/observe_event_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/groups/observe_group_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/safe_cubit.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_state.dart';
import 'package:flutter/cupertino.dart';

import '../../../base/errors.dart';

class AddExpenseBloc extends SafeCubit<AddExpenseState> {
  final _addExpenseUseCase = AddEventUseCase();
  final _deleteExpenseUseCase = DeleteExpenseUseCase();
  final _observeGroupUseCase = ObserveGroupUseCase();
  final _observeExpenseUseCase = ObserveGroupExpenseUseCase();
  final SharedPrefs _sharedPrefs;

  final descriptionTextController = TextEditingController();
  final PageController pageController = PageController();

  final String groupId;
  final String groupExpenseId;

  AddExpenseBloc(this._sharedPrefs, {required this.groupId, required this.groupExpenseId})
    : super(const AddExpenseState());

  bool get isChanged => true;

  Future<void> init() async {
    _observeExpenseUseCase.observe(groupId, groupExpenseId).listen((expense) {
      safeEmit(state.copyWith(groupExpense: expense));
      if (expense.sharedExpenses.length > 1 && state.view == ExpenseView.simple) {
        pageController.jumpToPage(1);
      }
    });
    _observeGroupUseCase.invoke(groupId).listen((group) {
      safeEmit(
        state.copyWith(
          people: [
            ...state.groupExpense.tempParticipants,
            ...state.group.people,
          ],
        ),
      );
    });
    if (state.groupExpense.id.isEmpty) {
      final groupDefCurrencyRate = _sharedPrefs.getExchangeRate(state.group.defaultCurrency);
      if (groupDefCurrencyRate == null) {
        updateCurrency(Currency.usd());
      } else {
        updateCurrency(Currency(symbol: state.group.defaultCurrency, rate: groupDefCurrencyRate));
      }
    }
  }

  void addExpense() async {
    try {
      safeEmit(state.copyWith(isLoading: true));
      await _addExpenseUseCase.launch(state.group, state.groupExpense);
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.unknown(e.toString())));
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }

  void onPayerSelected(Person person) {
    final groupExpense = state.groupExpense.copyWith(payer: person);
    safeEmit(state.copyWith(groupExpense: groupExpense));
  }

  void onQuickAddSharedExpense() {
    final expenses = List.of(state.groupExpense.sharedExpenses);
    final newExpense = SharedExpense(participants: state.group.people);
    expenses.add(newExpense);
    final copy = state.groupExpense.copyWith(sharedExpenses: expenses);
    safeEmit(state.copyWith(groupExpense: copy));
  }

  void addExpenseForUser(Person person) {
    final expenses = List.of(state.groupExpense.sharedExpenses);
    final newExpense = SharedExpense(participants: [person]);
    expenses.add(newExpense);
    final copy = state.groupExpense.copyWith(sharedExpenses: expenses);
    safeEmit(state.copyWith(groupExpense: copy));
  }

  Future<bool> deleteExpense() async {
    try {
      safeEmit(state.copyWith(isLoading: true));
      await _deleteExpenseUseCase.launch(state.group.id, state.groupExpense);
      return true;
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.serverError(e.toString())));
      return false;
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }

  void updateCurrency(Currency currency) {
    final copy = state.groupExpense.copyWith(currency: currency);
    safeEmit(state.copyWith(groupExpense: copy));
  }

  void uploadReceipt(Iterable<ScannedReceiptItem> receiptItems) {
    if (receiptItems.isEmpty) {
      return;
    }
    final sharedExpenses = receiptItems.map(
      (e) => SharedExpense(
        expense: e.expense,
        participants: state.group.people,
        description: e.description,
      ),
    );
    final copy = state.groupExpense.copyWith(sharedExpenses: sharedExpenses.toList());
    safeEmit(state.copyWith(groupExpense: copy));
  }

  void removeSharedExpense(SharedExpense sharedExpense) {
    if (state.groupExpense.sharedExpenses.length == 1) return;
    final expenseCopy = state.groupExpense.sharedExpenses.where((it) => it != sharedExpense);
    final copy = state.groupExpense.copyWith(sharedExpenses: expenseCopy.toList());
    safeEmit(state.copyWith(groupExpense: copy));
  }

  void updateParticipantsForExpense(SharedExpense sharedExpense, Iterable<Person> participants) {
    final expense = sharedExpense.copyWith(participants: participants.toList());
    // TODO
  }

  void updateSharedExpense(SharedExpense sharedExpense, num value) {
    final copy = sharedExpense.copyWith(expense: value);
    // TODO
  }

  void switchToSingle() {
    final copy = state.groupExpense.copyWith(
      sharedExpenses: [state.groupExpense.sharedExpenses.first],
    );
    safeEmit(state.copyWith(groupExpense: copy));
  }

  void updateDate(DateTime dateTime) {
    final copy = state.groupExpense.copyWith(date: dateTime.toIso8601String());
    safeEmit(state.copyWith(groupExpense: copy));
  }

  void updateDescription(String description) {
    final copy = state.groupExpense.copyWith(description: description);
    safeEmit(state.copyWith(groupExpense: copy));
  }

  void onAddTempParticipant(String name, SharedExpense sharedExpense) {
    final temps = [...state.groupExpense.tempParticipants, Person(name: name)];
    final copy = state.groupExpense.copyWith(tempParticipants: temps);
    safeEmit(state.copyWith(groupExpense: copy));
  }

  void onUpdateSurcharge(num value) {
    final copy = state.groupExpense.copyWith(
      surcharges: [Surcharge(name: "Surcharge", type: SurchargeType.percentage, value: value)],
    );
    safeEmit(state.copyWith(groupExpense: copy));
  }

  void resetChanges() {}

  @override
  Future<void> close() {
    pageController.dispose();
    descriptionTextController.dispose();
    return super.close();
  }
}
