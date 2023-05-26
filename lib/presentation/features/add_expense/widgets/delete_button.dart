import 'package:billsplit_flutter/presentation/dialogs/custom_dialog.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteExpenseButton extends StatelessWidget {
  const DeleteExpenseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    return IconButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return CustomDialog(
                title: "Are you sure you want to delete",
                primaryText: "Delete",
                secondaryText: "Cancel",
                onPrimaryClick: () {
                  Navigator.of(context).pop();
                  cubit.deleteExpense();
                },
                onSecondaryClick: () {
                  Navigator.of(context).pop();
                },
              );
            });
      },
      icon: const Icon(Icons.delete),
      color: Theme.of(context).colorScheme.error,
    );
  }
}
