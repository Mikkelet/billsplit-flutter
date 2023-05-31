import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/features/group/widgets/pay_debt/pay_custom_debt_view.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
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
    TextStyle style = Theme.of(context).textTheme.bodyLarge!;
    final String defaultCurrency =
        groupCubit.group.defaultCurrencyState.toUpperCase();
    final convertDebt = groupCubit.convertToDefaultCurrency(debt.second);
    final isDebt = debt.second > 0;

    if (isDebt) {
      text =
          "You owe $defaultCurrency ${convertDebt.fmt2dec()} to ${debt.first.displayName}";
      style = SplitsbyTextTheme.groupViewNegativeDebt(context);
    } else if (debt.second < 0) {
      text =
          "${debt.first.displayName} owes you $defaultCurrency ${convertDebt.abs().fmt2dec()}";
      style = SplitsbyTextTheme.groupViewPositiveDebt(context);
    }
    return SizedBox(
      child: Row(
        children: [
          Expanded(
            child: RoundedListItem(
              borderRadius: builder(() {
                if (isDebt) {
                  return const BorderRadius.horizontal(
                      right: Radius.circular(10), left: Radius.circular(30));
                } else {
                  return null;
                }
              }),
              align: Alignment.centerLeft,
              height: 64,
              child: Text(text, style: style),
            ),
          ),
          if (isDebt) const SizedBox(width: 4),
          if (isDebt)
            ClickableListItem(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(10),
                right: Radius.circular(30),
              ),
              height: 64,
              width: 64,
              onClick: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => PayCustomDebtView(
                    debt: Pair(debt.first,
                        groupCubit.convertToDefaultCurrency(debt.second)),
                    group: groupCubit.group,
                  ),
                );
              },
              child: Text(
                "Pay",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary),
              ),
            )
        ],
      ),
    );
  }
}
