import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/rounded_list_item.dart';
import '../bloc/add_expense_bloc.dart';

class ExpenseTotalView extends StatelessWidget {
  const ExpenseTotalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    return SizedBox(
      height: 64,
      child: RoundedListItem(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(width: 8),
                Text("Total", style: Theme.of(context).textTheme.labelSmall),
              ],
            ),
            Row(
              children: [
                Text(
                  cubit.groupExpense.total.fmt2dec(),
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(width: 8),
                Text(
                  cubit.groupExpense.currencyState.symbol.toUpperCase(),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
