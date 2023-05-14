import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/payment_event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/use_cases/add_event_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_state.dart';
import 'package:billsplit_flutter/utils/pair.dart';

class DebtCubit extends BaseCubit {
  late final _addEventUseCase = AddEventUseCase();

  DebtCubit();

  payDebt(Group group, Pair<Person, num> debt) {
    final currency = Currency(symbol: group.defaultCurrencyState, rate: 1);
    final payment = Payment(
        id: "",
        currency: currency,
        createdBy: user,
        timestamp: DateTime.now().millisecondsSinceEpoch,
        paidTo: debt.first,
        amount: debt.second);
    emit(Loading());
    _addEventUseCase.launch(group.id, payment).then((_) {
      emit(DebtAdded());
    }).catchError((error) {
      showError(error);
    });
  }
}
