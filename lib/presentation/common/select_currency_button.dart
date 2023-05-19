import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/presentation/dialogs/currency_picker/currency_picker_dialog.dart';
import 'package:flutter/material.dart';

class SelectCurrencyButton extends StatefulWidget {
  final String currency;

  const SelectCurrencyButton({required this.currency, Key? key}) : super(key: key);

  @override
  State<SelectCurrencyButton> createState() => _SelectCurrencyButtonState();
}

class _SelectCurrencyButtonState extends State<SelectCurrencyButton> {
  late String currencyState = widget.currency;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final response = await Navigator.of(context).push(CurrencyPickerDialog.getRoute());
        if (response is Currency) {
          setState(() {
            currencyState = response.symbol;
          });
        }
      },
      child: Text(currencyState.toUpperCase()),
    );
  }
}
