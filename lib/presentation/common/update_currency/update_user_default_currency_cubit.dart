import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';

class UpdateUserDefaultCurrencyCubit extends BaseCubit {

  void updateCurrency(Currency currency) {
    sharedPrefs.userPrefDefaultCurrency = currency.symbol;
    update();
  }
}