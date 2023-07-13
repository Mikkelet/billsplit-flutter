import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/add_expense_bloc.dart';

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
      onClick: () {
        cubit.onQuickAddSharedExpense();
      },
      child: const Icon(Icons.add),
    );
  }
}
