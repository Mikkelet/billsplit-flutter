import 'package:billsplit_flutter/data/local/preferences/shared_prefs.dart';
import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/payment_event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/use_cases/currency/convert_currency_use_case.dart';
import 'package:billsplit_flutter/domain/use_cases/events/add_event_usecase.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/presentation/base/bloc/safe_cubit.dart';
import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:billsplit_flutter/presentation/common/expense_textfield/expense_textfield_controller.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/debt_state.dart';
import 'package:billsplit_flutter/presentation/features/profile/bloc/profile_cubit.dart';
import 'package:billsplit_flutter/utils/pair.dart';
import 'package:billsplit_flutter/utils/utils.dart';

class DebtCubit extends SafeCubit<DebtState> {
  final _addEventUseCase = AddEventUseCase();
  final _convertCurrencyUseCase = ConvertCurrencyUseCase();
  final controller = ExpenseTextFieldController();
  final SharedPrefs _sharedPrefs;
  final ProfileCubit _profileCubit;

  final Group group;
  final Pair<Person, num> debt;

  DebtCubit(this.group, this.debt, this._sharedPrefs, this._profileCubit) : super(DebtState());

  void updateCurrency(String newCurrency) {
    final newMaxAmount = _convertCurrencyUseCase.launch(maxAmount, state.currency, newCurrency);
    if (newMaxAmount < state.amount || state.amount.fmt2dec() == maxAmount.fmt2dec()) {
      safeEmit(state.copyWith(amount: newMaxAmount.toDouble()));
    }
    safeEmit(state.copyWith(currency: newCurrency));
  }

  Future<void> payTempDebt() async {
    final num? rate = _sharedPrefs.getExchangeRate(state.currency);
    if (rate == null) {
      return;
    }

    final payment = Payment(
      id: "",
      currency: Currency(symbol: state.currency, rate: rate),
      createdBy: _profileCubit.user,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      paidTo: _profileCubit.user,
      paidBy: debt.first,
      amount: state.amount,
    );

    try {
      safeEmit(state.copyWith(isLoading: true));
      await _addEventUseCase.launch(group, payment);
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.unknown(e.toString())));
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }

  void payDebt() async {
    final num? rate = _sharedPrefs.getExchangeRate(state.currency);
    if (rate == null) {
      return;
    }

    Payment payment;
    if (debt.first.isTemp() && debt.second < 0) {
      payment = Payment(
        id: "",
        currency: Currency(symbol: state.currency, rate: rate),
        createdBy: _profileCubit.user,
        timestamp: DateTime.now().millisecondsSinceEpoch,
        paidTo: _profileCubit.user,
        paidBy: debt.first,
        amount: state.amount,
      );
    } else {
      payment = Payment(
        id: "",
        currency: Currency(symbol: state.currency, rate: rate),
        createdBy: _profileCubit.user,
        timestamp: DateTime.now().millisecondsSinceEpoch,
        paidTo: debt.first,
        paidBy: _profileCubit.user,
        amount: state.amount,
      );
    }
    try {
      safeEmit(state.copyWith(isLoading: true));
      await _addEventUseCase.launch(group, payment);
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.serverError(e.toString())));
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }

  num get maxAmount {
    return _convertCurrencyUseCase.launch(debt.second.abs(), group.defaultCurrency, state.currency);
  }

  void updateAmount(num value) {
    safeEmit(state.copyWith(amount: value.toDouble()));
  }
}
