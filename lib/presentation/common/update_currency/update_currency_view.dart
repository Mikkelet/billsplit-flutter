import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/dialogs/currency_picker/currency_picker_dialog.dart';
import 'package:flutter/material.dart';

import 'update_currency_cubit.dart';

class UpdateCurrencyView extends StatelessWidget {
  const UpdateCurrencyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget(
      create: (context) => UpdateCurrencyCubit(),
      child: BaseBlocBuilder<UpdateCurrencyCubit>(builder: (cubit, state) {
        return ClickableListItem(
          onClick: () async {
            final response = await Navigator.of(context)
                .push(CurrencyPickerDialog.getRoute());
            if (response is Currency) {
              cubit.updateCurrency(response);
            }
          },
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cubit.sharedPrefs.userPrefDefaultCurrency.toUpperCase(),
              ),
              CircleAvatar(
                  backgroundColor:
                      Theme.of(context).colorScheme.secondaryContainer,
                  child: const Icon(Icons.edit))
            ],
          ),
        );
      }),
    );
  }
}
