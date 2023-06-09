import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/default_text_field.dart';
import 'package:billsplit_flutter/presentation/dialogs/currency_picker/currency_picker_dialog.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/debt_cubit.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/debt_state.dart';
import 'package:billsplit_flutter/utils/pair.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/models/group.dart';

class PayCustomDebtView extends StatefulWidget {
  final Group group;
  final Pair<Person, num> debt;

  const PayCustomDebtView({Key? key, required this.debt, required this.group})
      : super(key: key);

  @override
  State<PayCustomDebtView> createState() => _PayCustomDebtViewState();
}

class _PayCustomDebtViewState extends State<PayCustomDebtView> {
  late final TextEditingController controller =
      TextEditingController(text: widget.debt.second.fmtTextField());

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget<DebtCubit>(
      listener: (context, cubit, state) {
        if (state is DebtPayed) {
          Navigator.of(context).pop();
        } else if (state is CurrencyChanged) {
          controller.text = cubit.amount.fmtTextField();
          print("\tStateChange, amount=${controller.text}");
        }
      },
      create: (context) => DebtCubit(widget.group, widget.debt),
      child: BaseBlocBuilder<DebtCubit>(builder: (cubit, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () async {
                          final response = await Navigator.of(context).push(
                              CurrencyPickerDialog.getRoute(
                                  convertToCurrency: cubit.currency));
                          if (response is Currency) {
                            cubit.updateCurrency(response.symbol);
                          }
                        },
                        child: Text(cubit.currency.toUpperCase())),
                    SizedBox(
                      width: 200,
                      child: ExpenseTextField(
                        maxValue: cubit.maxAmount,
                        textEditingController: controller,
                        onChange: (value) {
                          cubit.updateAmount(value);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (state is Loading) const CircularProgressIndicator(),
                    if (state is Main)
                      IconButton(
                        onPressed: cubit.amount == 0
                            ? null
                            : () {
                                cubit.payDebt();
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
