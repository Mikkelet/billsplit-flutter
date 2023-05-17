import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/payment_event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/use_cases/add_event_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/currency_usecases/convert_currency_use_case.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/debt_state.dart';
import 'package:billsplit_flutter/presentation/utils/errors_utils.dart';
import 'package:billsplit_flutter/utils/pair.dart';

class DebtCubit extends BaseCubit {
  final Group group;
  final Pair<Person, num> debt;
  late String currency = group.defaultCurrencyState;
  late num amount = debt.second;
  final _addEventUseCase = AddEventUseCase();
  final _convertCurrencyUseCase = ConvertCurrencyUseCase();

  DebtCubit(this.group, this.debt);

  void updateCurrency(String newCurrency) {
    amount = _convertCurrencyUseCase.launch(amount, currency, newCurrency);
    currency = newCurrency;
    emit(CurrencyChanged());
  }

  payDebt() {
    final num? rate = sharedPrefs.latestExchangeRates[currency];
    if (rate == null) {
      showError(UiException(3000,
          "$currency is not a valid currency! Please contact the developer"));
      return;
    }
    final payment = Payment(
      id: "",
      currency: Currency(symbol: currency, rate: rate),
      createdBy: user,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      paidTo: debt.first,
      amount: debt.second,
    );
    emit(Loading());
    _addEventUseCase.launch(group.id, payment).then((_) {
      emit(DebtPayed());
    }).catchError((error) {
      showError(error);
    });
  }

  num get maxAmount {
    return _convertCurrencyUseCase.launch(
        debt.second, group.defaultCurrencyState, currency);
  }

  void updateAmount(num value) {
    amount = value;
  }
}
