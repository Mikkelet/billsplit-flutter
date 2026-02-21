import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubmitExpenseButton extends StatelessWidget {
  const SubmitExpenseButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    final canSubmit = cubit.state.groupExpense.total > 0;
    return IconButton(
      onPressed: canSubmit
          ? () {
              cubit.addExpense();
            }
          : null,
      icon: const Icon(Icons.check),
    );
  }
}
