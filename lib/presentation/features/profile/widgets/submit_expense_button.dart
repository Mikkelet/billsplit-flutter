import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:flutter/material.dart';

class SubmitExpenseButton extends StatelessWidget {
  const SubmitExpenseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseBlocBuilder<AddExpenseBloc>(builder: (cubit, state) {
      final canSubmit = cubit.groupExpense.isChanged &&
          cubit.groupExpense.total > 0 &&
          cubit.groupExpense.sharedExpensesState
              .every((element) => element.expenseState > 0);
      return IconButton(
        onPressed: canSubmit
            ? () {
                cubit.addExpense();
              }
            : null,
        icon: const Icon(Icons.check),
      );
    });
  }
}
