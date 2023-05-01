import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/common/simple_button.dart';
import 'package:billsplit_flutter/presentation/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/group/widgets/pay_custom_debt_view.dart';
import 'package:billsplit_flutter/utils/pair.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DebtView extends StatelessWidget {
  final Pair<Person, num> debt;

  const DebtView({Key? key, required this.debt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = "";
    Color color = Colors.black;
    final isDebt = debt.second > 0;
    if (isDebt) {
      text = "You owe \$${debt.second.fmt2dec()} to ${debt.first.nameState}";
      color = Colors.redAccent;
    } else if (debt.second < 0) {
      text =
          "${debt.first.nameState} owes you \$${debt.second.abs().fmt2dec()}";
      color = Colors.green;
    }
    final groupCubit = context.read<GroupBloc>();
    return RoundedListItem(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(text, style: TextStyle(color: color))),
          const SizedBox(width: 32),
          if (isDebt)
            SimpleButton(
              onClick: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => PayCustomDebtView(
                    debt: debt,
                    groupId: groupCubit.group.id,
                  ),
                );
              },
              child: Text(
                "Pay",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary),
              ),
            )
        ],
      ),
    );
  }
}
