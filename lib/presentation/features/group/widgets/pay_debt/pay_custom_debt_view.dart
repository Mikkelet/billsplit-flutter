import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/expense_textfield/default_text_field.dart';
import 'package:billsplit_flutter/presentation/common/expense_textfield/expense_textfield_controller.dart';
import 'package:billsplit_flutter/presentation/common/simple_button.dart';
import 'package:billsplit_flutter/presentation/dialogs/currency_picker/currency_picker_dialog.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/debt_cubit.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/debt_state.dart';
import 'package:billsplit_flutter/utils/pair.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';

class PayCustomDebtView extends StatefulWidget {
  final Group group;
  final Pair<Person, num> debt;

  const PayCustomDebtView({Key? key, required this.debt, required this.group})
      : super(key: key);

  @override
  State<PayCustomDebtView> createState() => _PayCustomDebtViewState();
}

class _PayCustomDebtViewState extends SafeState<PayCustomDebtView> {
  late final controller = ExpenseTextFieldController();

  @override
  Widget build(BuildContext context) {
    String title;

    if(widget.debt.second > 0){
      title = "Pay your debt to ${widget.debt.first.nameState}";
    }else {
      title = "Mark ${widget.debt.first.nameState}'s debt as paid";
    }
    return BaseBlocWidget<DebtCubit>(
      listener: (context, cubit, state) {
        if (state is DebtPayed) {
          Navigator.of(context).pop();
        } else if (state is CurrencyChanged) {
          controller.text = cubit.amount.fmtTextField();
        }
      },
      create: (context) => DebtCubit(widget.group, widget.debt),
      child: BaseBlocBuilder<DebtCubit>(builder: (cubit, state) {
        controller.text = cubit.maxAmount.fmt2dec();

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 32),
                Text(title, style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SimpleButton(
                        onClick: () async {
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
