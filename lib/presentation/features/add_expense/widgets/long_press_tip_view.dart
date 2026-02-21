import 'package:billsplit_flutter/presentation/common/closable_tips_view.dart';
import 'package:billsplit_flutter/presentation/utils/bloc_utils.dart';
import 'package:flutter/material.dart';

class LongPressTipView extends StatelessWidget {
  const LongPressTipView({super.key});

  @override
  Widget build(BuildContext context) {
    return ClosableTipView(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      tip: "Tip: long press a user to quick-add an expense for them",
      hasSeen: context.prefs.hasSeenHoldToAddIndividualExpenseTip,
      onClose: () {
        context.prefs.hasSeenHoldToAddIndividualExpenseTip = true;
      },
    );
  }
}
