import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/subscription_service.dart';
import 'package:billsplit_flutter/domain/use_cases/services/add_service_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/services/delete_service_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/safe_cubit.dart';
import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:billsplit_flutter/presentation/common/expense_textfield/expense_textfield_controller.dart';
import 'package:billsplit_flutter/presentation/features/add_service/bloc/add_service_state.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/cupertino.dart';

class AddServiceBloc extends SafeCubit<AddServiceState> {
  final _addServiceUseCase = AddServiceUseCase();
  final _deleteServiceUseCase = DeleteServiceUseCase();

  AddServiceBloc(this.service, this.group) : super(const AddServiceState());

  final SubscriptionService service;
  final Group group;
  late final nameTextController = TextEditingController(text: service.nameState.value);
  late final expenseTextController = ExpenseTextFieldController(
    text: service.monthlyExpenseState.value.fmt2dec(readOnly: false),
  );

  Future<void> submitService() async {
    try {
      safeEmit(state.copyWith(isLoading: true));
      await _addServiceUseCase.launch(group.id, service);
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.serverError(e.toString())));
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }

  void onPayerClicked(Person person) {
    service.payerState.value = person;
  }

  Future<void> deleteService(SubscriptionService service) async {
    try {
      safeEmit(state.copyWith(isLoading: true));
      await _deleteServiceUseCase.launch(group.id, service);
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.serverError(e.toString())));
    } finally {
      safeEmit(state.copyWith(isLoading: false));
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
}
