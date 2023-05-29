import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/add_expense_bloc.dart';
import 'description_text_field.dart';
import 'expense_currency.dart';

class ExpenseDescriptionAndCurrencyView extends StatelessWidget {
  const ExpenseDescriptionAndCurrencyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    final groupExpense = cubit.groupExpense;
    return SizedBox(
      height: 64,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 5,
            child:
                DescriptionTextField(initialText: groupExpense.descriptionState),
          ),
          const SizedBox(width: 4),
          const Flexible(
            flex: 1,
            child: ExpenseCurrencyButton(),
          )
        ],
      ),
    );
  }
}
