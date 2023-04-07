
import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/add_expense/bloc/add_expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/individual_expense.dart';
import '../../../domain/models/person.dart';
import 'add_expense_event.dart';

class AddExpenseBloc extends Bloc<AddExpenseEvent, AddExpenseState> {
  final people = [0, 1, 2].map((e) => Person.dummy(e)).toImmutableList();
  late final expenseHolders =
      people.map((e) => IndividualExpense(person: e)).toImmutableList();

  AddExpenseBloc() : super(Loading()) {
    on<LoadExpenses>(_onLoadExpenses);
    on<ExpensesUpdated>(_onExpensesUpdated);
  }

  void _onLoadExpenses(
      LoadExpenses event, Emitter<AddExpenseState> emit) async {
    emit(Loading());
    await Future.delayed(const Duration(seconds: 2));
    emit(ExpensesLoaded(expenseHolders));
  }

  void _onExpensesUpdated(
      ExpensesUpdated event, Emitter<AddExpenseState> emit) {
    emit(ExpensesLoaded(expenseHolders));
  }
}
