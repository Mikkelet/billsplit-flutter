import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../_generated/presentation/features/add_expense/bloc/add_expense_state.freezed.dart';

@freezed
abstract class AddExpenseState with _$AddExpenseState {
  const factory AddExpenseState({
    @Default(false) bool isLoading,
    @Default(SplitsbyError.none()) SplitsbyError error,
    @Default(Group()) Group group,
    @Default(GroupExpense()) GroupExpense groupExpense,
    @Default([]) List<Person> people,
    @Default(ExpenseView.simple) ExpenseView view,
  }) = _AddExpenseState;
}

enum ExpenseView {
  simple,
  advanced;
}