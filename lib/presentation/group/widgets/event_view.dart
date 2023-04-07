import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/presentation/add_expense/expense_page.dart';
import 'package:flutter/material.dart';

class EventView extends StatelessWidget {
  final Event event;

  const EventView({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (event is GroupExpense) {
          Navigator.of(context)
              .push(AddExpensePage.getRoute(event as GroupExpense));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Text("Event ${event.id}"),
          event is GroupExpense
              ? Text("Expense \$${(event as GroupExpense).getTotal()}")
              : Container(),
          Text("Created by ${event.createdBy.name}"),
        ]),
      ),
    );
  }
}
