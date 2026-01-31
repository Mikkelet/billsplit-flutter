import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_bloc.dart';
import 'package:billsplit_flutter/presentation/features/group/widgets/pay_debt/pay_custom_debt_view.dart';
import 'package:billsplit_flutter/presentation/mutable_state.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
import 'package:billsplit_flutter/utils/pair.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DebtView extends StatelessWidget {
  final Pair<Person, num> debt;

  const DebtView({super.key, required this.debt});

  @override
  Widget build(BuildContext context) {
    final groupCubit = context.read<GroupBloc>();

    return MutableValue(
      mutableValue: groupCubit.group.defaultCurrencyState,
      builder: (context, currency) {
        String text = "";
        TextStyle style = Theme.of(context).textTheme.bodyLarge!;
        final String defaultCurrency = currency.toUpperCase();
        final isDebt = debt.second > 0;

        if (isDebt) {
          text =
          "You owe $defaultCurrency ${debt.second.fmt2dec()} to ${debt.first.displayName}";
          style = SplitsbyTextTheme.groupViewNegativeDebt(context);
        } else if (debt.second < 0) {
          text =
          "${debt.first.displayName} owes you $defaultCurrency ${debt.second.abs().fmt2dec()}";
          style = SplitsbyTextTheme.groupViewPositiveDebt(context);
        }
        final showPayButton = isDebt || debt.first.isTemp();

        return Row(
          children: [
            Expanded(
              child: RoundedListItem(
                align: Alignment.centerLeft,
                height: 64,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(text, style: style),
              ),
            ),
            if (showPayButton) const SizedBox(width: 4),
            if (showPayButton)
              ClickableListItem(
                color: Theme.of(context).colorScheme.secondaryContainer,
                height: 64,
                width: 64,
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
                child: _payButtonContent(context),
              )
          ],
        );
      }
    );
  }

  Widget _payButtonContent(BuildContext context) {
    if (debt.first.isTemp()) {
      return Icon(
        Icons.check,
        color: Theme.of(context).colorScheme.onSecondaryContainer,
      );
    }
    return Text(
      "Pay",
      style: Theme.of(context)
          .textTheme
          .labelMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer),
    );
  }
}
