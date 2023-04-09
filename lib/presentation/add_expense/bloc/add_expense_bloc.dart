import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/use_cases/add_event_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';

class AddExpenseBloc extends BaseCubit {
  final _addExpenseUseCase = AddEventUseCase();

  final String groupId;
  final GroupExpense groupExpense;

  AddExpenseBloc(this.groupId ,this.groupExpense) : super.withState(Main());

  void onExpensesUpdated() {
    emit(Main());
  }

  void addExpense() {
    _addExpenseUseCase.launch(groupId, groupExpense);
  }
}
