import 'dart:async';

import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/scanned_receipt_item.dart';
import 'package:billsplit_flutter/domain/models/shared_expense.dart';
import 'package:billsplit_flutter/domain/models/surcharge.dart';
import 'package:billsplit_flutter/domain/use_cases/events/add_event_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/events/delete_expense_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_state.dart';
import 'package:billsplit_flutter/presentation/mutable_state.dart';
import 'package:rxdart/rxdart.dart';

class AddExpenseBloc extends BaseCubit {
  final _addExpenseUseCase = AddEventUseCase();
  final _deleteExpenseUseCase = DeleteExpenseUseCase();

  final Group group;
  final GroupExpense groupExpense;
  final MutableState<Iterable<Person>> peopleStream = <Person>[].obs();

  Stream<bool> get individualExpenseStream {
    final participantsStream = groupExpense.sharedExpensesState.value
        .map((event) => event.participantsState.stateStream);
    final streams = [
      groupExpense.totalStream,
      groupExpense.currencyState.stateStream,
      groupExpense.payerState.stateStream,
      ...participantsStream,
    ];
    return CombineLatestStream(streams, (values) => true);
  }

  AddExpenseBloc(this.group, this.groupExpense) : super.withState(Main()) {
    if (groupExpense.id.isEmpty) {
      final groupDefCurrencyRate =
          sharedPrefs.getExchangeRate(group.defaultCurrencyState.value);
      if (groupDefCurrencyRate == null) {
        updateCurrency(Currency.usd());
      } else {
        updateCurrency(Currency(
            symbol: group.defaultCurrencyState.value,
            rate: groupDefCurrencyRate));
      }
    }
    group.peopleState
        .combine(groupExpense.tempParticipantsState, (x, y) => [...x, ...y])
        .listen((data) {
      peopleStream.value = data;
    }).addTo(compositeSubscription);
  }

  void addExpense() {
    _addExpenseUseCase.launch(group, groupExpense);
    emit(AddExpenseSuccess());
  }

  void onPayerSelected(Person person) {
    groupExpense.payerState.value = person;
  }

  void onQuickAddSharedExpense() {
    final sharedExpense = groupExpense.addNewSharedExpense(
        withParticipants: group.peopleState.value);
    emit(QuickAddSharedExpense(sharedExpense));
  }

  void addExpenseForUser(Person person) {
    final sharedExpense =
        groupExpense.addNewSharedExpense(withParticipants: [person]);
    emit(QuickAddSharedExpense(sharedExpense));
  }

  void deleteExpense() {
    showLoading();
    _deleteExpenseUseCase.launch(group.id, groupExpense).then((_) {
      emit(ExpenseDeleted());
    }).catchError((err, st) {
      showError(err, st);
    });
  }

  void updateCurrency(Currency currency) {
    print("qqq change currency ${currency.symbol}");
    groupExpense.currencyState.value = currency;
  }

  uploadReceipt(Iterable<ScannedReceiptItem> receiptItems) {
    if (receiptItems.isEmpty) {
      showToast("No items found");
      return;
    }
    final sharedExpenses = receiptItems.map((e) => SharedExpense(
        expense: e.expense,
        participants: group.peopleState.value,
        description: e.description));
    groupExpense.sharedExpensesState.clear();
    groupExpense.sharedExpensesState.addAll(sharedExpenses);
  }

  void removeSharedExpense(SharedExpense sharedExpense) {
    groupExpense.removeSharedExpense(sharedExpense);
    if (groupExpense.sharedExpensesState.isEmpty) {
      groupExpense.addNewSharedExpense(
          withParticipants: group.peopleState.value);
    }
  }

  void updateParticipantsForExpense(
      SharedExpense sharedExpense, Iterable<Person> participants) {
    sharedExpense.participantsState.value = participants;
  }

  void updateSharedExpense(SharedExpense sharedExpense, num value) {
    sharedExpense.expenseState.value = value;
  }

  void switchToSingle() {
    groupExpense.sharedExpensesState.value =
        groupExpense.sharedExpensesState.sublist(0, 1);
  }

  void updateDate(DateTime dateTime) {
    groupExpense.dateState.value = dateTime;
  }

  void updateDescription(String description) {
    groupExpense.descriptionState.value = description;
  }

  void onAddTempParticipant(String name, SharedExpense sharedExpense) {
    groupExpense.addTempParticipant(name, sharedExpense);
    update();
  }

  void onUpdateSurcharge(num value) {
    groupExpense.surchargesState.clear();
    groupExpense.surchargesState.add(Surcharge(
        name: "Surcharge", type: SurchargeType.percentage, value: value));
    update();
  }
}
