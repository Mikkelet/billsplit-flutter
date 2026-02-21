import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/add_expense_bloc.dart';
import 'description_text_field.dart';
import 'expense_currency.dart';

class ExpenseDescriptionAndCurrencyView extends StatelessWidget {
  const ExpenseDescriptionAndCurrencyView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    final groupExpense = cubit.state.groupExpense;
    return SizedBox(
      height: 64,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: DescriptionTextField(initialText: groupExpense.description),
          ),
          const SizedBox(width: 4),
          const SizedBox(width: 64, height: 64, child: ExpenseCurrencyButton()),
        ],
      ),
    );
  }
}
