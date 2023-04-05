
import 'package:flutter/foundation.dart';

@immutable
abstract class AddExpenseEvent{}

class LoadExpenses extends AddExpenseEvent{}
class ExpensesUpdated extends AddExpenseEvent{}