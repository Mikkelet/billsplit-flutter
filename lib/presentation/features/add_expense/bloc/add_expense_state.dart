import 'package:billsplit_flutter/domain/models/shared_expense.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';

class AddExpenseSuccess extends Main {}

class ExpenseUpdated extends Main {}

class QuickAddSharedExpense extends Main {
  final SharedExpense sharedExpense;

  QuickAddSharedExpense(this.sharedExpense);
}

class ExpenseDeleted extends Main{}