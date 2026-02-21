import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/presentation/features/currency_picker/currency_picker_dialog.dart';
import 'package:billsplit_flutter/presentation/features/currency_picker/currency_picker_route.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:flutter/material.dart';

class SelectCurrencyButton extends StatefulWidget {
  final String currency;

  const SelectCurrencyButton({required this.currency, super.key});

  @override
  State<SelectCurrencyButton> createState() => _SelectCurrencyButtonState();
}

class _SelectCurrencyButtonState extends SafeState<SelectCurrencyButton> {
  late String currency = widget.currency;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final response = await CurrencyPickerRoute().push(context);
        if (response is Currency) {
          setState(() {
            currency = response.symbol;
          });
        }
      },
      child: Text(currency.toUpperCase()),
    );
  }
}
