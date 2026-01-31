import 'package:billsplit_flutter/domain/models/shared_expense.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/common/expense_textfield/default_text_field.dart';
import 'package:billsplit_flutter/presentation/common/expense_textfield/expense_textfield_controller.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/widgets/expense_currency.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleExpenseField extends StatefulWidget {
  final SharedExpense expense;

  const SingleExpenseField({
    super.key,
    required this.expense,
  });

  @override
  State<SingleExpenseField> createState() => _SingleExpenseFieldState();
}

class _SingleExpenseFieldState extends State<SingleExpenseField> {
  late final textEditingController = ExpenseTextFieldController(
      text: widget.expense.expenseState.value.fmtTextField());

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    return Row(
      children: [
        Expanded(
          child: RoundedListItem(
            height: 64,
            padding: EdgeInsets.zero,
            child: Column(
              mainAxisAlignment: builder(() {
                if (textEditingController.hasError) {
                  return MainAxisAlignment.spaceBetween;
                }
                return MainAxisAlignment.center;
              }),
              children: [
                ExpenseTextField(
                  onChange: (value) {
                    cubit.updateSharedExpense(widget.expense, value);
                  },
                  showErrorText: false,
                  canBeZero: false,
                  fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                  textAlign: TextAlign.center,
                  autoFocus: textEditingController.text.isEmpty,
                  textEditingController: textEditingController,
                ),
                if (textEditingController.hasError)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 10,
                      color: Theme.of(context).colorScheme.errorContainer,
                    ),
                  )
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        const SizedBox(
          width: 64,
          height: 64,
          child: ExpenseCurrencyButton(),
        )
      ],
    );
  }
}
