import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/use_cases/get_currencies_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';

class CurrencyPickerCubit extends BaseCubit {
  final _getCurrenciesUseCase = GetCurrenciesUseCase();
  late List<Currency> currencies;

  void loadCurrencies() {
    showLoading();
    _getCurrenciesUseCase.launch().then((value) {
      currencies = value;
      emit(Main());
    }).catchError((error) {
      showError(error);
    });
  }
}
