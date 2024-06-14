import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/sync_state.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/expense_page.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/mutable_state.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseEventView extends StatelessWidget {
  final GroupExpense groupExpense;

  const ExpenseEventView({super.key, required this.groupExpense});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (groupExpense.syncState == SyncState.failed)
          Text(
            "Error occurred. Press to resubmit",
            style: TextStyle(color: Theme.of(context).colorScheme.error),
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
            return Theme.of(context).colorScheme.primaryContainer;
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
              MutableValue(
                  mutableValue: groupExpense.descriptionState,
                  builder: (context, description) {
                    final formatted = _formatDescription(description);
                    final fontStyle = _descriptionFontStyle(description);
                    return Text(formatted,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontStyle: fontStyle));
                  }),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder(
                    stream: groupExpense.totalStream,
                    initialData: groupExpense.total,
                    builder: (context, snapshot) {
                      final total = snapshot.requireData;
                      return Text(
                        total.fmt2dec(),
                        style: Theme.of(context).textTheme.titleLarge,
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  MutableValue(
                      mutableValue: groupExpense.currencyState,
                      builder: (context, currency) {
                        return Text(
                          currency.symbol.toUpperCase(),
                          style: TextStyle(
                              fontSize: 15,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary),
                        );
                      }),
                ],
              ),
              const SizedBox(height: 8),
              MutableValue(
                  mutableValue: groupExpense.payerState,
                  builder: (context, payer) {
                    return Text(
                      "paid by ${payer.nameState} on ${groupExpense.dateString}",
                      style: Theme.of(context).textTheme.bodySmall,
                    );
                  })
            ],
          ),
        ),
      ],
    );
  }

  String _formatDescription(String description) {
    return description.isNotEmpty
        ? "\"${groupExpense.descriptionState}\""
        : "${groupExpense.createdBy.displayName} added a new expense";
  }

  FontStyle? _descriptionFontStyle(String description) {
    return description.isNotEmpty ? FontStyle.italic : null;
  }
}
