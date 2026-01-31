import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/dialogs/currency_picker/currency_picker_dialog.dart';
import 'package:billsplit_flutter/presentation/dialogs/custom_dialog.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/mutable_state.dart';
import 'package:flutter/material.dart';

class ExpenseCurrencyButton extends StatelessWidget {
  const ExpenseCurrencyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseBlocBuilder<AddExpenseBloc>(
      builder: (cubit, state) => ClickableListItem(
        padding: EdgeInsets.zero,
        color: Theme.of(context).colorScheme.secondaryContainer,
        onClick: () async {
          if (cubit.groupExpense.id.isNotEmpty) {
            final warningResponse = await showDialog(
                context: context,
                builder: (context) => CustomDialog(
                      title: "Warning",
                      text:
                          "Updating the currency will also update the exchange rate, which can affect the cost of the expense.",
                      secondaryText: "Go back",
                      onPrimaryClick: () {
                        Navigator.of(context).pop(true);
                      },
                      onSecondaryClick: () {
                        Navigator.of(context).pop(false);
                      },
                    ));
            if (warningResponse == false) {
              return;
            }
          }

          if (context.mounted) {
            final response = await Navigator.of(context).push(
              CurrencyPickerDialog.getRoute(
                convertToCurrency: cubit.group.defaultCurrencyState.value,
              ),
            );
            if (response is Currency) {
              cubit.updateCurrency(response);
            }
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MutableValue(
                mutableValue: cubit.groupExpense.currencyState,
                builder: (context, currency) {
                  return Text(
                    currency.symbol.toUpperCase(),
                    style: Theme.of(context).textTheme.labelSmall,
                  );
                }),
          ],
        ),
      ),
    );
  }
}
