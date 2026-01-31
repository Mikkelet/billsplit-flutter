import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/presentation/mutable_state.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';

class GroupDebtView extends StatelessWidget {
  final Group group;
  final num debt;
  const GroupDebtView({super.key, required this.group, required this.debt});

  @override
  Widget build(BuildContext context) {
    if (debt == 0) {
      return const SizedBox();
    }
    return MutableValue(
      mutableValue: group.defaultCurrencyState,
      builder: (context, currency) {
        return Row(
          children: [
            if (debt > 0)
              Expanded(
                child: Text(debt.fmt2dec(),
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: SplitsbyTextTheme.groupViewNegativeDebt(context)),
              ),
            if (debt < 0)
              Expanded(
                child: Text(debt.abs().fmt2dec(),
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: SplitsbyTextTheme.groupViewPositiveDebt(context)),
              ),
            const SizedBox(width: 4),
            Text(
              currency,
              style: SplitsbyTextTheme.groupViewDebtCurrency(context),
            )
          ],
        );
      }
    );

  }
}
