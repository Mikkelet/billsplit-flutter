import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/debt_cubit.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/debt_state.dart';
import 'package:billsplit_flutter/utils/pair.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:flutter/material.dart';


class PayTempDebtView extends StatefulWidget {
  final Group group;
  final Pair<Person, num> debt;

  const PayTempDebtView({Key? key, required this.debt, required this.group})
      : super(key: key);

  @override
  State<PayTempDebtView> createState() => _PayTempDebtViewState();
}

class _PayTempDebtViewState extends SafeState<PayTempDebtView> {

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget<DebtCubit>(
      listener: (context, cubit, state) {
        if (state is DebtPayed) {
          Navigator.of(context).pop();
        }
      },
      create: (context) => DebtCubit(widget.group, widget.debt),
      child: BaseBlocBuilder<DebtCubit>(builder: (cubit, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery
                    .of(context)
                    .viewInsets
                    .bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Has ${widget.debt.first.nameState} payed this debt?",
                        style: Theme
                            .of(context)
                            .textTheme
                            .labelLarge),
                  ],
                ),
                const SizedBox(height: 16),
                Builder(builder: (context) {
                  if (state is Loading) {
                    return const CircularProgressIndicator();
                  }
                  return IconButton(
                    onPressed: () {
                      cubit.payTempDebt();
                    },
                    icon: const Icon(Icons.check),
                  );
                }),
                const SizedBox(height: 32)
              ],
            ),
          ),
        );
      }),
    );
  }
}
