import 'dart:async';

import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/subscription_service.dart';
import 'package:billsplit_flutter/domain/use_cases/add_event_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/add_group_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/add_person_to_group_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/currency_usecases/convert_currency_use_case.dart';
import 'package:billsplit_flutter/domain/use_cases/get_group_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/leave_group_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/observe_debts_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/observe_events_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/observe_services_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/updatable_textfield.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_state.dart';
import 'package:billsplit_flutter/utils/pair.dart';
import 'package:collection/collection.dart';

class GroupBloc extends BaseCubit {
  final _getGroupUseCase = GetGroupUseCase();
  final _observeEventsUseCase = ObserveEventsUseCase();
  final _observeServicesUseCase = ObserveServicesUseCase();
  final _observeDebtsUseCase = ObserveDebtsUseCase();
  final _leaveGroupUseCase = LeaveGroupUseCase();
  final _addPersonToGroupUseCase = AddPersonToGroupUseCase();
  final _addGroupUseCase = AddGroupUseCase();
  final _addExpenseUseCase = AddEventUseCase();
  final _convertCurrencyUseCase = ConvertCurrencyUseCase();

  final Group group;
  GroupPageNav navIndex = GroupPageNav.events;
  UpdateTextFieldState editGroupNameState = UpdateTextFieldState.display;

  GroupBloc(this.group) : super.withState(SyncingGroup(GroupPageNav.events));

  Stream<List<Event>> getEventsStream() =>
      _observeEventsUseCase.observe(group.id).map((event) =>
          event.toList().sortedBy((e) => e.timestamp).reversed.toList());

  Stream<List<SubscriptionService>> getServicesStream() =>
      _observeServicesUseCase.observe(group.id).map(
          (event) => event.toList().sortedBy((element) => element.nameState));

  Stream<Iterable<Pair<Person, num>>> getDebtsStream() =>
      _observeDebtsUseCase.observe(group.id);

  void loadGroup() async {
    emit(SyncingGroup(navIndex));
    _getGroupUseCase
        .launch(group.id)
        .then((value) => emit(GroupLoaded(navIndex)))
        .catchError((err, ss) {
      print(ss);

      showError(err);
    });
  }

  void showEvents() => showPage(GroupPageNav.events);

  void showServices() => showPage(GroupPageNav.services);

  void showDebt() => showPage(GroupPageNav.events);

  void showPage(GroupPageNav nav) {
    navIndex = nav;
    final newState = GroupLoaded(navIndex);
    emit(newState);
  }

  void showSettings() {
    showPage(GroupPageNav.settings);
  }

  void leaveGroup() {
    showLoading();
    _leaveGroupUseCase.launch(group.id).then((value) {
      emit(GroupLeft());
    }).catchError((err) {
      showError(err);
    });
  }

  void addPersonToGroup(Person person) {
    emit(AddingPersonToGroup());
    _addPersonToGroupUseCase.launch(group, person).then((value) {
      emit(Main());
    }).catchError((onError) {
      showError(onError);
    });
  }

  editGroupName(bool isEditing) {
    if (isEditing) {
      _updateEditGroupNameState(UpdateTextFieldState.isEditing);
    } else {
      _updateEditGroupNameState(UpdateTextFieldState.display);
    }
  }

  _updateEditGroupNameState(UpdateTextFieldState state) {
    editGroupNameState = state;
    emit(Main());
  }

  updateGroupName(String newName) {
    group.nameState = newName;
    _updateEditGroupNameState(UpdateTextFieldState.isUpdating);
    _addGroupUseCase.launch(group).then((value) {
      _updateEditGroupNameState(UpdateTextFieldState.display);
    }).catchError((error) {
      group.reset();
      _updateEditGroupNameState(UpdateTextFieldState.display);
    });
  }

  void retryAddExpense(GroupExpense expense) {
    _addExpenseUseCase.launch(group.id, expense);
  }

  num convertToDefaultCurrency(num amount) {
    final userPrefCurrency = sharedPrefs.userPrefDefaultCurrency;
    return _convertCurrencyUseCase.launch(amount, "usd", userPrefCurrency);
  }

  void updateCurrency(Currency currency) {
    group.defaultCurrencyState = currency.symbol;
    emit(Main());
  }
}
