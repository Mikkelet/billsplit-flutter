import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/sync_state.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/expense_page.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../extensions.dart';

class ExpenseEventView extends StatelessWidget {
  final GroupExpense groupExpense;

  const ExpenseEventView({Key? key, required this.groupExpense})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final description = groupExpense.descriptionState.isNotEmpty
        ? "\"${groupExpense.descriptionState}\""
        : "${groupExpense.createdBy.nameState} added a new expense";
    final fontStyle =
        groupExpense.descriptionState.isNotEmpty ? FontStyle.italic : null;
    return Column(
      children: [
        if (groupExpense.syncState == SyncState.failed)
          const Text(
            "Error occurred. Press to resubmit",
            style: TextStyle(color: Colors.redAccent),
          )
        else if (groupExpense.syncState == SyncState.pending)
          const SizedBox(
              height: 20, width: 20, child: CircularProgressIndicator()),
        ClickableListItem(
          color: builder(() {
            if (groupExpense.syncState == SyncState.pending) {
              return Theme.of(context).highlightColor;
            }
            if (groupExpense.syncState == SyncState.failed) {
              return Theme.of(context).colorScheme.errorContainer;
            }
            return null;
          }),
          onClick: () {
            final cubit = context.read<GroupBloc>();
            if (groupExpense.syncState == SyncState.synced) {
              Navigator.of(context).push(AddExpensePage.getRoute(
                  cubit.user, cubit.group, groupExpense));
            } else if (groupExpense.syncState == SyncState.failed) {
              cubit.retryAddExpense(groupExpense);
            }
          },
          child: Column(
            children: [
              Text(description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontStyle: fontStyle)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    groupExpense.total.fmt2dec(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    groupExpense.currencyState.symbol.toUpperCase(),
                    style: TextStyle(
                        fontSize: 15, color: Theme.of(context).disabledColor),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "paid by ${groupExpense.payerState.nameState}",
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
        ),
      ],
    );
  }
}
