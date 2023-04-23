import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/use_cases/add_event_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/utils/pair.dart';

class DebtCubit extends BaseCubit {
  late final _addEventUseCase = AddEventUseCase();

  DebtCubit();

  payDebt(String groupId, Pair<Person, num> debt) {
    final payment = Payment(
        id: "",
        createdBy: user,
        timestamp: DateTime.now().millisecondsSinceEpoch,
        paidTo: debt.first,
        amount: debt.second);
    emit(Loading());
    _addEventUseCase.launch(groupId, payment).then((_) {
      emit(Main());
    }).catchError((error) {
      showError(error);
    });
  }
}
