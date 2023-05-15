import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/common/simple_button.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/features/group/widgets/pay_custom_debt_view.dart';
import 'package:billsplit_flutter/utils/pair.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DebtView extends StatelessWidget {
  final Pair<Person, num> debt;

  const DebtView({Key? key, required this.debt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupCubit = context.read<GroupBloc>();

    String text = "";
    Color color = Colors.black;
    final String userCurrency = groupCubit.sharedPrefs.userPrefDefaultCurrency;
    final convertDebt = groupCubit.convertToDefaultCurrency(debt.second);
    final isDebt = debt.second > 0;

    if (isDebt) {
      text = "You owe $userCurrency ${convertDebt.fmt2dec()} to ${debt.first.nameState}";
      color = Colors.redAccent;
    } else if (debt.second < 0) {
      text =
          "${debt.first.nameState} owes you $userCurrency ${convertDebt.abs().fmt2dec()}";
      color = Colors.green;
    }
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
                    group: groupCubit.group,
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
