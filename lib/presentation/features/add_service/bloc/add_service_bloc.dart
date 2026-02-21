import 'dart:async';

import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/subscription_service.dart';
import 'package:billsplit_flutter/domain/use_cases/services/add_service_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/services/delete_service_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/services/observe_service_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/safe_cubit.dart';
import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:billsplit_flutter/presentation/common/expense_textfield/expense_textfield_controller.dart';
import 'package:billsplit_flutter/presentation/features/add_service/bloc/add_service_state.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/cupertino.dart';

import '../../../../domain/use_cases/groups/observe_group_usecase.dart';

class AddServiceBloc extends SafeCubit<AddServiceState> {
  final _observeServiceUseCase = ObserveServiceUseCase();
  final _observeGroupUseCase = ObserveGroupUseCase();
  final _addServiceUseCase = AddServiceUseCase();
  final _deleteServiceUseCase = DeleteServiceUseCase();

  AddServiceBloc(this.serviceId, this.groupId) : super(const AddServiceState()) {
    init();
  }

  SubscriptionService get service => state.requireService;

  Group get group => state.requireGroup;

  final String serviceId;
  final String groupId;
  late final StreamSubscription<SubscriptionService> _serviceStream;
  late final StreamSubscription<Group> _groupStream;
  late final nameTextController = TextEditingController();
  late final expenseTextController = ExpenseTextFieldController();

  void init() {
    _serviceStream =
        _observeServiceUseCase.observe(groupId, serviceId).listen((service) {
          safeEmit(state.copyWith(service: service));
          nameTextController.text = service.nameState.value;
          expenseTextController.text = service.monthlyExpenseState.value.fmt2dec(readOnly: false);
        })..onError((e, st) {
          logError(e, st);
          safeEmit(state.copyWith(error: SplitsbyError.unknown(e.toString())));
        });
    _groupStream =
        _observeGroupUseCase.invoke(groupId).listen((group) {
          safeEmit(state.copyWith(group: group));
        })..onError((e, st) {
          logError(e, st);
          safeEmit(state.copyWith(error: SplitsbyError.unknown(e.toString())));
        });
  }

  Future<void> submitService() async {
    try {
      await _addServiceUseCase.launch(group.id, service);
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.unknown(e.toString())));
    }
  }

  void onPayerClicked(Person person) {
    service.payerState.value = person;
  }

  Future<void> deleteService(SubscriptionService service) async {
    try {
      await _deleteServiceUseCase.launch(group.id, service);
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.unknown(e.toString())));
    }
  }

  bool isValid() {
    return nameTextController.text.isEmpty;
  }

  void updateCurrency(String symbol) {
    service.currencyState.value = symbol;
  }

  void updateParticipants(Iterable<Person> participants) {
    service.participantsState.value = participants;
    if (!service.participantsState.value.contains(service.payerState.value)) {
      service.payerState.value = service.participantsState.value.first;
    }
    if (service.participantsState.isEmpty) {
      service.participantsState.add(service.payerState.value);
    }
  }

  @override
  Future<void> close() async {
    await _serviceStream.cancel();
    await _groupStream.cancel();
    return super.close();
  }
}
