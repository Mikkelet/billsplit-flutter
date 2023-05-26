import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/shared_expense.dart';
import 'package:billsplit_flutter/domain/use_cases/add_event_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/delete_expense_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/scan_receipt_usecase2.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_state.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';

class AddExpenseBloc extends BaseCubit {
  final Group group;
  final GroupExpense groupExpense;
  late final _addExpenseUseCase = AddEventUseCase();
  final _deleteExpenseUseCase = DeleteExpenseUseCase();

  AddExpenseBloc(this.group, this.groupExpense) : super.withState(Main()) {
    if (groupExpense.id.isEmpty) {
      final groupDefCurrencyRate =
          sharedPrefs.latestExchangeRates[group.defaultCurrencyState];
      if (groupDefCurrencyRate == null) {
        groupExpense.currencyState = Currency.USD();
      } else {
        groupExpense.currencyState = Currency(
            symbol: group.defaultCurrencyState, rate: groupDefCurrencyRate);
      }
    }
  }

  void onExpensesUpdated() {
    emit(Main());
  }

  void addExpense() {
    _addExpenseUseCase.launch(group.id, groupExpense);
    emit(AddExpenseSuccess());
  }

  void onPayerSelected(Person person) {
    groupExpense.payerState = person;
    emit(Main());
  }

  void onQuickAddSharedExpense() {
    final sharedExpense =
        groupExpense.addNewSharedExpense(withParticipants: group.people);
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
    groupExpense.currencyState = currency;
    onExpensesUpdated();
  }

  uploadReceipt(Iterable<ScannedReceiptItem> receiptItems) {
    if (receiptItems.isEmpty) {
      showToast("No items found");
      return;
    }
    final sharedExpenses = receiptItems.map((e) => SharedExpense(
        expense: e.expense,
        participants: group.people,
        description: e.description));
    groupExpense.sharedExpensesState.clear();
    groupExpense.sharedExpensesState.addAll(sharedExpenses);
    emit(Main());
  }
}
