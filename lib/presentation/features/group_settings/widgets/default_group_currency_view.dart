import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/features/currency_picker/currency_picker_dialog.dart';
import 'package:billsplit_flutter/presentation/features/currency_picker/currency_picker_route.dart';
import 'package:billsplit_flutter/presentation/features/group_settings/bloc/group_settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DefaultGroupCurrencyView extends StatelessWidget {
  const DefaultGroupCurrencyView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GroupSettingsCubit>();
    return ClickableListItem(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      onClick: () async {
        final response = await CurrencyPickerRoute(
          convertToCurrency: cubit.group.defaultCurrency,
        ).push(context);
        if (response is Currency) {
          cubit.updateCurrency(response);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            cubit.group.defaultCurrency.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall,
          ),
          if (cubit.state.updatingCurrencyIsLoading)
            const CircularProgressIndicator()
          else
            const Icon(Icons.arrow_right),
        ],
      ),
    );
  }
}
