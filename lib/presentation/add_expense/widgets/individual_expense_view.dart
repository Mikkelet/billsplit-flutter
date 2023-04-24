import 'package:billsplit_flutter/domain/models/individual_expense.dart';
import 'package:billsplit_flutter/presentation/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/common/payer_view.dart';
import 'package:billsplit_flutter/presentation/common/default_text_field.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IndividualExpenseView extends StatefulWidget {
  final IndividualExpense individualExpense;

  const IndividualExpenseView(this.individualExpense, {super.key});

  @override
  State<IndividualExpenseView> createState() => _IndividualExpenseViewState();
}

class _IndividualExpenseViewState extends State<IndividualExpenseView> {
  late final textController =
      TextEditingController(text: "${widget.individualExpense.expenseState}");

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PayerView(
          person: widget.individualExpense.person,
          isPayer: _isPayer(widget.individualExpense, cubit),
          onClick: () {
            cubit.onPayerSelected(widget.individualExpense.person);
          },
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (cubit.groupExpense.payerState.uid ==
                  widget.individualExpense.person.uid)
                Text("${widget.individualExpense.person.nameState} is paying",
                    textAlign: TextAlign.left)
              else
                Text(widget.individualExpense.person.nameState,
                    textAlign: TextAlign.left),
              Row(
                children: [
                  Expanded(
                    child: ExpenseTextField(
                      textEditingController: textController,
                      onChange: (value) {
                        widget.individualExpense.expenseState = value;
                        cubit.onExpensesUpdated();
                      },
                    ),
                  ),
                  if (getTotalForUser(cubit) > 0)
                    Text(
                      "\$${getTotalForUser(cubit).fmt2dec()}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  num getTotalForUser(AddExpenseBloc cubit) {
    return widget.individualExpense.expenseState +
        cubit.groupExpense
            .getSharedExpensesForPerson(widget.individualExpense.person);
  }

  bool _isPayer(IndividualExpense individualExpense, AddExpenseBloc cubit) {
    return cubit.groupExpense.payerState.uid == individualExpense.person.uid;
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
