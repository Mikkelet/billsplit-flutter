import 'package:billsplit_flutter/domain/models/expense_holder.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class AddExpenseState {}

class Loading extends AddExpenseState {}
class ExpensesLoaded extends AddExpenseState {
  final List<IndividualExpense> individualExpenses;
  ExpensesLoaded(this.individualExpenses);

  num sumExpenses() => individualExpenses.sumExpenses();
}