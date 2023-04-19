import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';

class ExpenseEventView extends StatelessWidget {
  final GroupExpense groupExpense;

  const ExpenseEventView({Key? key, required this.groupExpense})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final description = groupExpense.description.isNotEmpty
        ? groupExpense.description
        : "${groupExpense.payerState.nameState} added a new expense";
    return Column(
      children: [Text(description), Text("\$${groupExpense.total.fmt2dec()}")],
    );
  }
}
