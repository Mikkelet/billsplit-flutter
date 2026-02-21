import 'package:billsplit_flutter/domain/models/shared_expense.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/utils/list_position.dart';
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

class _SharedExpensesViewState extends State<SharedExpensesView> {
  late bool showAll = widget.showAll;
  static const int _showAllLimit = 3;

  static const _randomMenuItems = ["Burger", "Fries", "Wine", "Soda", "Chicken nuggets"];

  static String _getHintTextIndex(int index) {
    if (index >= _randomMenuItems.length) {
      return _getHintTextIndex(index - _randomMenuItems.length);
    }
    return _randomMenuItems[index];
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    final state = cubit.state;
    return Builder(
      builder: (context) {
        final allExpenses = state.groupExpense.sharedExpenses;
        Iterable<SharedExpense> sharedExpenses;
        if (showAll && allExpenses.length > _showAllLimit) {
          sharedExpenses = allExpenses;
        } else {
          sharedExpenses = allExpenses.take(_showAllLimit);
        }
        return Column(
          children: [
            ...sharedExpenses.mapIndexed(
              (i, SharedExpense e) {
                final listPos = ListPosition.calculatePosition(i, sharedExpenses);
                final autoFocus =
                    (listPos == ListPosition.last || listPos == ListPosition.single) &&
                    e.expense == 0;

                return SharedExpenseView(
                  key: UniqueKey(),
                  sharedExpense: e,
                  hintText: _getHintTextIndex(i),
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
                ),
              ),
          ],
        );
      },
    );
  }
}
