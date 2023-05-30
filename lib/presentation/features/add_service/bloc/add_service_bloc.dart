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
    showLoading();
    addServiceUseCase.launch(group.id, service).then((value) {
      emit(ServiceAdded());
    }).catchError((err, st) {
      showError(err, st);
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
    }).catchError((error, st) {
      showError(error, st);
    });
  }

  void updateCurrency(String symbol) {
    service.currencyState = symbol;
    onServiceUpdated();
  }

  void updateParticipants(List<Person> participants) {
    service.participantsState = participants;
    if (!service.participantsState.contains(service.payerState)) {
      service.payerState = service.participantsState.first;
    }
    if (service.participantsState.isEmpty) {
      service.participantsState.add(service.payerState);
    }
    onServiceUpdated();
  }
}
