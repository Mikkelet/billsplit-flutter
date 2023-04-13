import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/individual_expense.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/use_cases/add_event_usecase.dart';
import 'package:billsplit_flutter/presentation/add_expense/bloc/add_expense_state.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';

class AddExpenseBloc extends BaseCubit {
  final String groupId;
  final GroupExpense groupExpense;
  late final _addExpenseUseCase = AddEventUseCase(groupId, groupExpense);

  AddExpenseBloc(this.groupId, this.groupExpense) : super.withState(Main());

  void onExpensesUpdated() {
    emit(Main());
  }

  void addExpense() {
    emit(Loading());
    _addExpenseUseCase.launch().then((value) {
      emit(AddExpenseSuccess());
    }).catchError((err) {
      showError(err);
    });
  }

  void onPayerSelected(Person person) {
    if (person.uid == groupExpense.sharedExpense.person.uid) return;
    groupExpense.payerState = person;
    emit(Main());
  }

  void onParticipantClicked(IndividualExpense individualExpense, bool? value) {
    individualExpense.isParticipantState = value ?? true;
    emit(Main());
  }

}
