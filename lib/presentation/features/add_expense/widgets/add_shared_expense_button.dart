import 'package:billsplit_flutter/domain/models/shared_expense.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_shared_expense_view.dart';

class AddSharedExpenseButton extends StatelessWidget {
  const AddSharedExpenseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    return ClickableListItem(
      padding: EdgeInsets.zero,
      color: Theme.of(context).colorScheme.secondaryContainer,
      borderRadius: BorderRadius.circular(10),
      height: 48,
      width: 48,
      onClick: () async {
        final sharedExpense =
            SharedExpense.newInstance([...cubit.group.people]);
        showModalBottomSheet(
          enableDrag: true,
          isScrollControlled: true,
          useSafeArea: true,
          context: context,
          builder: (context) => AddSharedExpenseView(
            onSubmit: () {
              cubit.groupExpense.sharedExpensesState.add(sharedExpense);
              Navigator.of(context).pop();
              cubit.onExpensesUpdated();
            },
            group: cubit.group,
            groupExpense: cubit.groupExpense,
            sharedExpense: sharedExpense,
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
