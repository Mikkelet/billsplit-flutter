import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/presentation/add_expense/expense_page.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/group/widgets/events/expense_event_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventView extends StatelessWidget {
  final Event event;

  const EventView({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClickableListItem(
      onClick: () {
        _onTap(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Builder(
            builder: (context) {
              if (event is GroupExpense) {
                return ExpenseEventView(groupExpense: event as GroupExpense);
              }
              if (event is Payment) {
                return Text(
                    "Payment by ${event.createdBy
                        .nameState}: \$${(event as Payment).amount}");
              }
              return Container();
            }
        ),
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
