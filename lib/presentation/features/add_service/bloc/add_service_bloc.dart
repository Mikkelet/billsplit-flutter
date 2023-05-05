import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/subscription_service.dart';
import 'package:billsplit_flutter/domain/use_cases/add_service_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/delete_service_usecase.dart';
import 'package:billsplit_flutter/presentation/features/add_service/bloc/add_service_state.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';

class AddServiceBloc extends BaseCubit {
  final addServiceUseCase = AddServiceUseCase();
  final deleteServiceUseCase = DeleteServiceUseCase();
  final SubscriptionService service;
  final Group group;

  AddServiceBloc(this.service, this.group) : super();

  void onServiceUpdated() {
    emit(Main());
  }

  void submitService() {
    emit(Loading());
    addServiceUseCase.launch(group.id, service).then((value) {
      emit(ServiceAdded());
    }).catchError((err) {
      showError(err);
    });
  }

  void onPayerClicked(Person person) {
    service.payerState = person;
    emit(Main());
  }

  void deleteService(SubscriptionService service) {
    showLoading();
    deleteServiceUseCase.launch(group.id, service).then((value) {
      emit(ServiceDeleted());
    }).catchError((error) {
      showError(error);
    });
  }
}
