import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/payment_event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/use_cases/currency/convert_currency_use_case.dart';
import 'package:billsplit_flutter/domain/use_cases/events/add_event_usecase.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/debt_state.dart';
import 'package:billsplit_flutter/presentation/utils/errors_utils.dart';
import 'package:billsplit_flutter/utils/pair.dart';
import 'package:billsplit_flutter/utils/utils.dart';

class DebtCubit extends BaseCubit {
  final _addEventUseCase = AddEventUseCase();
  final _convertCurrencyUseCase = ConvertCurrencyUseCase();

  final Group group;
  final Pair<Person, num> debt;
  late String currency = group.defaultCurrencyState;
  late num amount = debt.second.abs();

  DebtCubit(this.group, this.debt);

  void updateCurrency(String newCurrency) {
    final newMaxAmount =
        _convertCurrencyUseCase.launch(maxAmount, currency, newCurrency);
    if (newMaxAmount < amount || amount.fmt2dec() == maxAmount.fmt2dec()) {
      amount = newMaxAmount;
    }
    currency = newCurrency;
    emit(CurrencyChanged());
  }

  update(){
    emit(Main());
  }

  payTempDebt(){
    final num? rate = sharedPrefs.latestExchangeRates[currency.toUpperCase()];
    if (rate == null) {
      showError(
          UiException(3000,
              "$currency is not a valid currency! Please contact the developer"),
          null);
      return;
    }

    final payment = Payment(
      id: "",
      currency: Currency(symbol: currency, rate: rate),
      createdBy: user,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      paidTo: user,
      paidBy: debt.first,
      amount: amount,
    );

    emit(Loading());
    _addEventUseCase.launch(group, payment).then((_) {
      emit(DebtPayed());
    }).catchError((error, st) {
      showError(error, st);
    });
  }

  payDebt() {
    final num? rate = sharedPrefs.latestExchangeRates[currency.toUpperCase()];
    if (rate == null) {
      showError(
          UiException(3000,
              "$currency is not a valid currency! Please contact the developer"),
          null);
      return;
    }

    Payment payment;
    if (debt.first.isTemp() && debt.second < 0) {
      payment = Payment(
        id: "",
        currency: Currency(symbol: currency, rate: rate),
        createdBy: user,
        timestamp: DateTime.now().millisecondsSinceEpoch,
        paidTo: user,
        paidBy: debt.first,
        amount: amount,
      );
    } else {
      payment = Payment(
        id: "",
        currency: Currency(symbol: currency, rate: rate),
        createdBy: user,
        timestamp: DateTime.now().millisecondsSinceEpoch,
        paidTo: debt.first,
        paidBy: user,
        amount: amount,
      );
    }

    emit(Loading());
    _addEventUseCase.launch(group, payment).then((_) {
      emit(DebtPayed());
    }).catchError((error, st) {
      showError(error, st);
    });
  }

  num get maxAmount {
    return _convertCurrencyUseCase.launch(
        debt.second.abs(), group.defaultCurrencyState, currency);
  }

  void updateAmount(num value) {
    amount = value;
  }
}
