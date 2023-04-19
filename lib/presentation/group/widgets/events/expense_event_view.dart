import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/presentation/add_expense/expense_page.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseEventView extends StatelessWidget {
  final GroupExpense groupExpense;

  const ExpenseEventView({Key? key, required this.groupExpense})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final description = groupExpense.description.isNotEmpty
        ? groupExpense.description
        : "${groupExpense.payerState.nameState} added a new expense";
    return ClickableListItem(
      onClick: () {
        final cubit = context.read<GroupBloc>();
        Navigator.of(context).push(
            AddExpensePage.getRoute(cubit.user, cubit.group, groupExpense));
      },
      child: Column(
        children: [
          Text(description),
          const SizedBox(height: 8),
          Text(
            "\$${groupExpense.total.fmt2dec()}",
            style: Theme.of(context).textTheme.titleLarge,
          )
        ],
      ),
    );
  }
}
