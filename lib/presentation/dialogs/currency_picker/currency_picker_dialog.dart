import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';

import 'currency_picker_cubit.dart';

class CurrencyPickerDialog extends StatefulWidget {
  const CurrencyPickerDialog({Key? key}) : super(key: key);

  @override
  State<CurrencyPickerDialog> createState() => _CurrencyPickerDialogState();

  static get route =>
      MaterialPageRoute(builder: (context) => const CurrencyPickerDialog());
}

class _CurrencyPickerDialogState extends State<CurrencyPickerDialog> {
  String filter = "";

  _onChange(String? value) {
    setState(() {
      filter = value?.toLowerCase() ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [CloseButton()],
      ),
      body: BaseBlocWidget(
        create: (context) => CurrencyPickerCubit(),
        child: BaseBlocBuilder<CurrencyPickerCubit>(builder: (cubit, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  RoundedListItem(
                      child: TextField(
                    onChanged: _onChange,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "USD",
                        counterText: ""),
                    autofocus: true,
                    maxLength: 10,
                    maxLines: 1,
                  )),
                  const SizedBox(height: 32),
                  ...cubit.currencies
                      .where((element) => filter.isNotEmpty
                          ? element.symbol.toLowerCase().startsWith(filter)
                          : true)
                      .map((currency) {
                    return TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(currency);
                      },
                      style: const ButtonStyle(alignment: Alignment.centerLeft),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            currency.symbol.toUpperCase(),
                          ),
                          Text(
                            "~${cubit.getRateForCurrency(currency).fmt2dec()} ${cubit.sharedPrefs.userPrefDefaultCurrency.toUpperCase()}",
                            style: TextStyle(
                                color: Theme.of(context).disabledColor),
                          )
                        ],
                      ),
                    );
                  })
                ].toList(),
              ),
            ),
          );
        }),
      ),
    );
  }
}
