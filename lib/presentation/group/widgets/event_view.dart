import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/presentation/add_expense/expense_page.dart';
import 'package:billsplit_flutter/presentation/group/bloc/group_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventView extends StatelessWidget {
  final Event event;

  const EventView({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _onTap(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          event is GroupExpense
              ? Text("Expense \$${(event as GroupExpense).total}")
              : Container(),
          event is Payment
              ? Text(
                  "Payment by ${event.createdBy.name}: \$${(event as Payment).amount}")
              : Container(),
          Text("Created by ${event.createdBy.name}"),
        ]),
      ),
    );
  }

  _onTap(BuildContext context) {
    if (event is GroupExpense) {
      final cubit = context.read<GroupBloc>();
      Navigator.of(context).push(AddExpensePage.getRoute(
          cubit.user, cubit.group, event as GroupExpense));
    }
  }
}
