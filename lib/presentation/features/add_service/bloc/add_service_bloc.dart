import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/subscription_service.dart';
import 'package:billsplit_flutter/domain/use_cases/services/add_service_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/services/delete_service_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/features/add_service/bloc/add_service_state.dart';

class AddServiceBloc extends BaseCubit {
  final _addServiceUseCase = AddServiceUseCase();
  final _deleteServiceUseCase = DeleteServiceUseCase();
  final SubscriptionService service;
  final Group group;

  AddServiceBloc(this.service, this.group) : super();

  void submitService() {
    showLoading();
    _addServiceUseCase.launch(group.id, service).then((value) {
      emit(ServiceAdded());
    }).catchError((err, st) {
      showError(err, st);
    });
  }

  void onPayerClicked(Person person) {
    service.payerState.value = person;
  }

  void deleteService(SubscriptionService service) {
    showLoading();
    _deleteServiceUseCase.launch(group.id, service).then((value) {
      emit(ServiceDeleted());
    }).catchError((error, st) {
      showError(error, st);
    });
  }

  void updateCurrency(String symbol) {
    service.currencyState.value = symbol;
  }

  void updateParticipants(List<Person> participants) {
    service.participantsState.value = participants;
    if (!service.participantsState.value.contains(service.payerState.value)) {
      service.payerState.value = service.participantsState.value.first;
    }
    if (service.participantsState.isEmpty) {
      service.participantsState.add(service.payerState.value);
    }
  }
}
