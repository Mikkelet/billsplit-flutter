import 'package:billsplit_flutter/domain/models/shared_expense.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/mutable_state.dart';
import 'package:billsplit_flutter/utils/list_position.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'shared_expense_view.dart';

class SharedExpensesView extends StatefulWidget {
  final bool showAll;

  const SharedExpensesView({super.key, required this.showAll});

  @override
  State<SharedExpensesView> createState() => _SharedExpensesViewState();
}

class _SharedExpensesViewState extends SafeState<SharedExpensesView> {
  late bool showAll = widget.showAll;
  static const int _showAllLimit = 3;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    return MutableValue(
        mutableValue: cubit.groupExpense.sharedExpensesState,
        builder: (context, sharedExpensesState) {
          Iterable<SharedExpense> sharedExpenses;
          if (showAll && sharedExpensesState.length > _showAllLimit) {
            sharedExpenses = sharedExpensesState;
          } else {
            sharedExpenses = sharedExpensesState.take(_showAllLimit);
          }
          return Column(
            children: [
              ...sharedExpenses.mapIndexed(
                (i, e) {
                  final listPos = ListPosition.calculatePosition(
                      i, sharedExpensesState);
                  final autoFocus = (listPos == ListPosition.last ||
                          listPos == ListPosition.single) &&
                      e.expenseState.value == 0;
                  return SharedExpenseView(
                    key: Key("${e.hashCode}"),
                    sharedExpense: e,
                    listPosition: listPos,
                    autoFocus: autoFocus,
                  );
                },
              ),
              if (!showAll)
                ClickableListItem(
                    height: 48,
                    onClick: () {
                      setState(() {
                        showAll = true;
                      });
                    },
                    child: Text(
                      "Show all",
                      style: Theme.of(context).textTheme.labelLarge,
                    ))
            ],
          );
        });
  }
}
