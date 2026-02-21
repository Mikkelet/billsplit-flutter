import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/features/currency_picker/currency_picker_dialog.dart';
import 'package:billsplit_flutter/presentation/dialogs/custom_dialog.dart';
import 'package:billsplit_flutter/presentation/features/add_expense/bloc/add_expense_bloc.dart';
import 'package:billsplit_flutter/presentation/features/currency_picker/currency_picker_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseCurrencyButton extends StatelessWidget {
  const ExpenseCurrencyButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddExpenseBloc>();
    return ClickableListItem(
      padding: EdgeInsets.zero,
      color: Theme.of(context).colorScheme.secondaryContainer,
      onClick: () async {
        if (cubit.state.groupExpense.id.isNotEmpty) {
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
            ),
          );
          if (warningResponse == false) {
            return;
          }
        }

        if (context.mounted) {
          final response = await CurrencyPickerRoute().push(context);
          if (response is Currency) {
            cubit.updateCurrency(response);
          }
        }
      },
      child: Text(
        cubit.state.group.defaultCurrency.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}
