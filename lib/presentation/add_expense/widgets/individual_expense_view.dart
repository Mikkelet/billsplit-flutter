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
    final isShared = widget.individualExpense.person.uid ==
        cubit.groupExpense.sharedExpense.person.uid;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.individualExpense.person.nameState,
            textAlign: TextAlign.left),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (isShared)
              const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.group, size: 64))
            else
              PayerView(
                person: widget.individualExpense.person,
                isPayer: _isPayer(widget.individualExpense, cubit),
                isSharedExpense:
                    _isSharedExpense(widget.individualExpense, cubit),
                onClick: () {
                  cubit.onPayerSelected(widget.individualExpense.person);
                },
              ),
            Flexible(
              child: ExpenseTextField(
                textEditingController: textController,
                onChange: (value) {
                  widget.individualExpense.expenseState = value;
                  cubit.onExpensesUpdated();
                },
              ),
            ),
            if (_shouldShowSharedExpense(widget.individualExpense, cubit))
              Text(
                  key: Key(getTotalForUser(cubit).fmt2dec()),
                  "\$${getTotalForUser(cubit).fmt2dec()}"),
          ],
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

  bool _shouldShowSharedExpense(
      IndividualExpense individualExpense, AddExpenseBloc cubit) {
    return !_isSharedExpense(individualExpense, cubit) &&
        widget.individualExpense.isParticipantState;
  }

  bool _isSharedExpense(
      IndividualExpense individualExpense, AddExpenseBloc cubit) {
    return widget.individualExpense.person.uid ==
        cubit.groupExpense.sharedExpense.person.uid;
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
