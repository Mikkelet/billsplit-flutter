import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';

class AddExpenseBloc extends BaseCubit {
  final GroupExpense groupExpense;

  AddExpenseBloc(this.groupExpense) : super.withState(Main());

  void onExpensesUpdated() {
    emit(Main());
  }
}
