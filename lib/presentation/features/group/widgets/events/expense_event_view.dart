import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/expense_page.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseEventView extends StatelessWidget {
  final GroupExpense groupExpense;

  const ExpenseEventView({Key? key, required this.groupExpense})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final description = groupExpense.descriptionState.isNotEmpty
        ? "\"${groupExpense.descriptionState}\""
        : "${groupExpense.createdBy.nameState} added a new expense";
    final fontStyle = groupExpense.descriptionState.isNotEmpty ? FontStyle.italic : null;
    return ClickableListItem(
      onClick: () {
        final cubit = context.read<GroupBloc>();
        Navigator.of(context).push(
            AddExpensePage.getRoute(cubit.user, cubit.group, groupExpense));
      },
      child: Column(
        children: [
          Text(description,textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontStyle: fontStyle)),
          const SizedBox(height: 8),
          Text(
            "\$${groupExpense.total.fmt2dec()}",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text("paid by ${groupExpense.payerState.nameState}", style: Theme.of(context).textTheme.bodySmall,)
        ],
      ),
    );
  }
}
