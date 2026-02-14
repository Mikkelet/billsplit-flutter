import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/dialogs/currency_picker/currency_picker_dialog.dart';
import 'package:billsplit_flutter/presentation/features/group_settings/bloc/group_settings_cubit.dart';
import 'package:billsplit_flutter/presentation/features/group_settings/bloc/group_settings_state.dart';
import 'package:billsplit_flutter/presentation/features/group_settings/widgets/default_currency/default_group_currency_cubit.dart';
import 'package:billsplit_flutter/presentation/mutable_state.dart';
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
        final response = await Navigator.of(context).push(
          CurrencyPickerDialog.getRoute(convertToCurrency: cubit.group.defaultCurrencyState.value),
        );
        if (response is Currency) {
          cubit.updateCurrency(response);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MutableValue(
            mutableValue: cubit.group.defaultCurrencyState,
            builder: (context, currency) {
              return Text(
                currency.toUpperCase(),
                style: Theme.of(context).textTheme.labelSmall,
              );
            },
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
