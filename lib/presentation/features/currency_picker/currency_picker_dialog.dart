import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_scaffold.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/features/currency_picker/bloc/currency_picker_state.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
import 'package:billsplit_flutter/presentation/utils/bloc_utils.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'bloc/currency_picker_cubit.dart';

class CurrencyPickerDialog extends StatelessWidget {
  const CurrencyPickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CurrencyPickerCubit>();
    return BaseScaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        automaticallyImplyLeading: false,
        actions: const [CloseButton()],
      ),
      body: BlocBuilder<CurrencyPickerCubit, CurrencyPickerState>(
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return RefreshIndicator(
            onRefresh: () async {
              cubit.loadCurrencies();
              await Future.delayed(const Duration(seconds: 1));
            },
            child: ListenableBuilder(
              listenable: cubit.filterController,
              builder: (context, _) {
                final filter = cubit.filterController.text;
                return SingleChildScrollView(
                  primary: false,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 32),
                        RoundedListItem(
                          child: TextField(
                            controller: cubit.filterController,
                            onChanged: (_) {},
                            style: SplitsbyTextTheme.textFieldStyle(context),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "USD, EUR",
                              suffixIcon: const Icon(Icons.search),
                              hintStyle: TextStyle(
                                color: Theme.of(context).colorScheme.inversePrimary,
                              ),
                              counterText: "",
                            ),
                            maxLength: 10,
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox(height: 32),
                        if (cubit.recentCurrencies.isNotEmpty && filter.isEmpty)
                          const Text("Recent currencies"),
                        if (cubit.recentCurrencies.isNotEmpty && filter.isEmpty)
                          ...cubit.recentCurrencies.map(
                            (currency) => _currencyButton(context, cubit, currency),
                          ),
                        if (cubit.recentCurrencies.isNotEmpty && filter.isEmpty)
                          const Text("All currencies"),
                        Builder(
                          builder: (context) {
                            final filtered = state.currencies
                                .where(
                                  (element) => filter.isNotEmpty
                                      ? element.symbol.toLowerCase().startsWith(filter)
                                      : true,
                                )
                                .toList();
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: filtered.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final currency = filtered[index];
                                return _currencyButton(context, cubit, currency);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _currencyButton(BuildContext context, CurrencyPickerCubit cubit, Currency currency) {
    final symbol = cubit.convertToCurrency ?? context.prefs.userPrefDefaultCurrency.toUpperCase();
    final rate = cubit.getRateForCurrency(currency.symbol);
    return TextButton(
      onPressed: () {
        cubit.onCurrencyPressed(currency);
        context.pop(currency);
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
            key: Key(symbol),
            "${symbol == currency.symbol ? "" : "~"}${rate.fmt2dec()} ${symbol.toUpperCase()}",
            style: SplitsbyTextTheme.exchangeRateLabel(context),
          ),
        ],
      ),
    );
  }
}
