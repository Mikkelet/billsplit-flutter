import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/expense_textfield/default_text_field.dart';
import 'package:billsplit_flutter/presentation/common/expense_textfield/expense_textfield_controller.dart';
import 'package:billsplit_flutter/presentation/common/simple_button.dart';
import 'package:billsplit_flutter/presentation/features/currency_picker/currency_picker_dialog.dart';
import 'package:billsplit_flutter/presentation/features/currency_picker/currency_picker_route.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/debt_cubit.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/debt_state.dart';
import 'package:billsplit_flutter/utils/pair.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PayCustomDebtView extends StatelessWidget {
  const PayCustomDebtView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DebtCubit>();
    return BlocBuilder<DebtCubit, DebtState>(
      builder: (context, state) {
        String title;

        if (cubit.debt.second > 0) {
          title = "Pay your debt to ${cubit.debt.first.name}";
        } else {
          title = "Mark ${cubit.debt.first.name}'s debt as paid";
        }
        cubit.controller.text = cubit.state.amount.fmtTextField();

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                        final response = await CurrencyPickerRoute().push(context);
                        if (response is Currency) {
                          cubit.updateCurrency(response.symbol);
                        }
                      },
                      child: Text(state.currency.toUpperCase()),
                    ),
                    SizedBox(
                      width: 200,
                      child: ExpenseTextField(
                        maxValue: cubit.maxAmount,
                        textEditingController: cubit.controller,
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
                        onPressed: cubit.state.amount == 0
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
      },
    );
  }
}
