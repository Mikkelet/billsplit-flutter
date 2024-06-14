import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/dialogs/currency_picker/currency_picker_dialog.dart';
import 'package:billsplit_flutter/presentation/features/profile/widgets/profile_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateUserDefaultCurrencyView<T extends BaseCubit>
    extends StatelessWidget {
  // Should not be const because BLOC cannot always update const widgets
  const UpdateUserDefaultCurrencyView({super.key});

  void onClick(BuildContext context, T cubit) async {
    final response =
        await Navigator.of(context).push(CurrencyPickerDialog.getRoute());
    if (response is Currency) {
      cubit.sharedPrefs.userPrefDefaultCurrency = response.symbol;
      cubit.update();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<T>();
    final currency = cubit.sharedPrefs.userPrefDefaultCurrency.toUpperCase();
    return ProfileListItem(
      text: "Currency $currency",
      onClick: () async => onClick(context, cubit),
    );
  }
}
