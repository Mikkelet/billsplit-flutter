import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/subscription_service.dart';
import 'package:billsplit_flutter/domain/use_cases/add_service_usecase.dart';
import 'package:billsplit_flutter/presentation/add_service/bloc/add_service_state.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';

class AddServiceBloc extends BaseCubit {
  final addServiceUseCase = AddServiceUseCase();
  final SubscriptionService service;
  final String groupId;

  AddServiceBloc(this.service, this.groupId) : super();

  void monthlyExpenseUpdated() {
    emit(Main());
  }

  void submitService() {
    emit(Loading());
    addServiceUseCase.launch(groupId, service).then((value) {
      emit(ServiceAdded());
    }).catchError((err) {
      showError(err);
    });
  }

  void onPayerClicked(Person person) {
    service.payerState = person;
    emit(Main());
  }
}
