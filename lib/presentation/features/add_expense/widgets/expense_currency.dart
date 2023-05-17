import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/dialogs/currency_picker/currency_picker_dialog.dart';
import 'package:billsplit_flutter/presentation/dialogs/custom_dialog.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:flutter/material.dart';

class ExpenseCurrency extends StatelessWidget {
  const ExpenseCurrency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseBlocBuilder<AddExpenseBloc>(
      builder: (cubit, state) => ClickableListItem(
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
            final response =
                await Navigator.of(context).push(CurrencyPickerDialog.route);
            if (response is Currency) {
              cubit.updateCurrency(response);
            }
          }
        },
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              cubit.groupExpense.currencyState.symbol.toUpperCase(),
            ),
            if (cubit.groupExpense.id.isEmpty) const Icon(Icons.edit)
          ],
        ),
      ),
    );
  }
}
