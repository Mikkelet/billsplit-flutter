import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/dialogs/currency_picker/currency_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class UpdateUserDefaultCurrencyView<T extends BaseCubit> extends StatelessWidget {

  UpdateUserDefaultCurrencyView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<T>();
    return ClickableListItem(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      onClick: () async {
        final response =
            await Navigator.of(context).push(CurrencyPickerDialog.getRoute());
        if (response is Currency) {
          cubit.sharedPrefs.userPrefDefaultCurrency = response.symbol;
          cubit.update();
        }
      },
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            cubit.sharedPrefs.userPrefDefaultCurrency.toUpperCase(),
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const Icon(Icons.arrow_right)
        ],
      ),
    );
  }
}
