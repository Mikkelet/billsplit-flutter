import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/default_text_field.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/debt_cubit.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_state.dart';
import 'package:billsplit_flutter/utils/pair.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';

class PayCustomDebtView extends StatefulWidget {
  final String groupId;
  final Pair<Person, num> debt;

  const PayCustomDebtView({Key? key, required this.debt, required this.groupId})
      : super(key: key);

  @override
  State<PayCustomDebtView> createState() => _PayCustomDebtViewState();
}

class _PayCustomDebtViewState extends State<PayCustomDebtView> {
  late final TextEditingController controller =
      TextEditingController(text: widget.debt.second.fmtTextField());
  late num amount = widget.debt.second;

  @override
  void initState() {
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget<DebtCubit>(
      listener: (context, cubit, state) {
        if (state is DebtAdded) {
          Navigator.of(context).pop();
        }
      },
      create: (context) => DebtCubit(),
      child: BaseBlocBuilder<DebtCubit>(builder: (cubit, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 32),
                SizedBox(
                  width: 200,
                  child: ExpenseTextField(
                    maxValue: widget.debt.second,
                    autoFocus: true,
                    textEditingController: controller,
                    onChange: (value) {
                      amount = value;
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (state is Loading) const CircularProgressIndicator(),
                    if (state is Main)
                      IconButton(
                        onPressed: amount == 0
                            ? null
                            : () {
                                cubit.payDebt(widget.groupId,
                                    Pair(widget.debt.first, amount));
                              },
                        icon: const Icon(Icons.check),
                      ),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      }),
    );
  }
}
