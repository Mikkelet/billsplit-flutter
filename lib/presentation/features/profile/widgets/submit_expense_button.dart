import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/mutable_state.dart';
import 'package:flutter/material.dart';

class SubmitExpenseButton extends StatelessWidget {
  const SubmitExpenseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseBlocBuilder<AddExpenseBloc>(builder: (cubit, state) {
      return StreamBuilder(
          stream: cubit.groupExpense.isChangeStream,
          initialData: false,
          builder: (context, snapshot) {
            final canSubmit = snapshot.requireData && cubit.groupExpense.total > 0;
            return IconButton(
              onPressed: canSubmit
                  ? () {
                      cubit.addExpense();
                    }
                  : null,
              icon: const Icon(Icons.check),
            );
          });
    });
  }
}
