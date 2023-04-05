import 'package:billsplit_flutter/domain/models/expense_holder.dart';
import 'package:billsplit_flutter/presentation/add_expense/bloc/add_expense_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/add_expense_event.dart';

class IndividualExpenseView extends StatefulWidget {

  final IndividualExpense _individualExpense;

  const IndividualExpenseView(this._individualExpense, {Key? key, }) : super(key: key);

  @override
  State<IndividualExpenseView> createState() => _IndividualExpenseViewState();
}

class _IndividualExpenseViewState extends State<IndividualExpenseView> {
  @override
  Widget build(BuildContext context) {

    return Column(children: [
      Text(widget._individualExpense.person.name),
      TextField(
        keyboardType: TextInputType.number,
        onChanged: (text) {
          num inputAsNumber = 0.0;
          try {
            inputAsNumber = num.parse(text);
          } catch (e) {
            inputAsNumber = 0;
            if (kDebugMode) {
              print(e);
            }
          }
          setState(() {
            widget._individualExpense.expense = inputAsNumber;
            context.read<AddExpenseBloc>().add(ExpensesUpdated());
          });
        },
      ),
      Text(widget._individualExpense.expense.toString()),
    ],);
  }
}
