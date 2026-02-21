import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/presentation/features/currency_picker/currency_picker_dialog.dart';
import 'package:billsplit_flutter/presentation/features/currency_picker/currency_picker_route.dart';
import 'package:billsplit_flutter/presentation/features/profile/widgets/profile_list_item.dart';
import 'package:billsplit_flutter/presentation/main_cubit.dart';
import 'package:billsplit_flutter/presentation/utils/bloc_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateUserDefaultCurrencyView extends StatelessWidget {
  const UpdateUserDefaultCurrencyView({super.key});

  void onClick(BuildContext context) async {
    final response = await CurrencyPickerRoute().push(context);
    if (response is Currency && context.mounted) {
      context.prefs.userPrefDefaultCurrency = response.symbol;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currency = context.prefs.userPrefDefaultCurrency.toUpperCase();
    return ProfileListItem(
      text: "Currency $currency",
      onClick: () async => onClick(context),
    );
  }
}
