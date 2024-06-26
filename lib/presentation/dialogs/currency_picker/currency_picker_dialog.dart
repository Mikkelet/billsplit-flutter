import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/base_scaffold.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/mutable_state.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';

import 'currency_picker_cubit.dart';

class CurrencyPickerDialog extends StatefulWidget {
  final String? convertToCurrency;

  const CurrencyPickerDialog({this.convertToCurrency, super.key});

  @override
  State<CurrencyPickerDialog> createState() => _CurrencyPickerDialogState();

  static getRoute({String? convertToCurrency}) => slideUpRoute(
        CurrencyPickerDialog(
          convertToCurrency: convertToCurrency,
        ),
      );
}

class _CurrencyPickerDialogState extends SafeState<CurrencyPickerDialog> {
  String filter = "";

  _onChange(String? value) {
    setState(() {
      filter = value?.toLowerCase() ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        automaticallyImplyLeading: false,
        actions: const [CloseButton()],
      ),
      body: BaseBlocWidget(
        create: (context) => CurrencyPickerCubit(widget.convertToCurrency),
        child: BaseBlocBuilder<CurrencyPickerCubit>(builder: (cubit, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return RefreshIndicator(
            onRefresh: () async {
              cubit.loadCurrencies();
              await Future.delayed(const Duration(seconds: 1));
            },
            child: SingleChildScrollView(
              primary: false,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    RoundedListItem(
                      child: TextField(
                        onChanged: _onChange,
                        style: SplitsbyTextTheme.textFieldStyle(context),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "USD, EUR",
                            suffixIcon: const Icon(Icons.search),
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary),
                            counterText: ""),
                        maxLength: 10,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(height: 32),
                    if (cubit.recentCurrencies.isNotEmpty && filter.isEmpty)
                      const Text("Recent currencies"),
                    if (cubit.recentCurrencies.isNotEmpty && filter.isEmpty)
                      ...cubit.recentCurrencies.map((currency) =>
                          _currencyButton(
                              Key(currency.symbol), cubit, currency)),
                    if (cubit.recentCurrencies.isNotEmpty && filter.isEmpty)
                      const Text("All currencies"),
                    MutableValue(
                        mutableValue: cubit.currencies,
                        builder: (context, currencies) {
                          final filtered = currencies
                              .where((element) => filter.isNotEmpty
                                  ? element.symbol
                                      .toLowerCase()
                                      .startsWith(filter)
                                  : true)
                              .toList();
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filtered.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final currency = filtered[index];
                              return _currencyButton(
                                  Key(currency.symbol), cubit, currency);
                            },
                          );
                        })
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _currencyButton(
      Key key, CurrencyPickerCubit cubit, Currency currency) {
    final symbol = widget.convertToCurrency ??
        cubit.sharedPrefs.userPrefDefaultCurrency.toUpperCase();
    final rate = cubit.getRateForCurrency(currency.symbol);
    return TextButton(
      onPressed: () {
        cubit.onCurrencyPressed(currency);
        Navigator.of(context).maybePop(currency);
      },
      style: const ButtonStyle(alignment: Alignment.centerLeft),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            currency.symbol.toUpperCase(),
            style: SplitsbyTextTheme.currencyTitle(context),
          ),
          Text(
              key: key,
              "${symbol == currency.symbol ? "" : "~"}${rate.fmt2dec()} ${symbol.toUpperCase()}",
              style: SplitsbyTextTheme.exchangeRateLabel(context)),
        ],
      ),
    );
  }
}
