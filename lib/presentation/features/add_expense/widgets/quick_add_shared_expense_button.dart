import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/add_expense_bloc.dart';

class QuickAddSharedExpenseButton extends StatelessWidget {
  const QuickAddSharedExpenseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    return IconButton(
      onPressed: () {
        cubit.onQuickAddSharedExpense();
      },
      icon: const Icon(Icons.bolt),
    );
  }
}
