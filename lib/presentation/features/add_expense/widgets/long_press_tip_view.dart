import 'package:billsplit_flutter/presentation/common/closable_tips_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/add_expense_bloc.dart';

class LongPressTipView extends StatelessWidget {
  const LongPressTipView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    return ClosableTipView(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      tip: "Tip: long press a user to quick-add an expense for them",
      hasSeen: cubit.sharedPrefs.hasSeenHoldToAddIndividualExpenseTip,
      onClose: () {
        cubit.sharedPrefs.hasSeenHoldToAddIndividualExpenseTip = true;
      },
    );
  }
}
