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
import 'package:billsplit_flutter/domain/use_cases/currency_usecases/get_exchange_rates_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/get_group_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/leave_group_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/observe_debts_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/observe_events_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/observe_services_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/storage/upload_group_picture_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_state.dart';
import 'package:billsplit_flutter/utils/pair.dart';
import 'package:billsplit_flutter/utils/utils.dart';
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
  final _getExchangeRatesUseCase = GetExchangeRatesUseCase();
  final _uploadGroupPicture = UploadGroupPictureUseCase();

  final Group group;
  GroupPageNav navIndex = GroupPageNav.events;

  GroupBloc(this.group) : super.withState(SyncingGroup(GroupPageNav.events));

  Stream<List<Event>> getEventsStream() =>
      _observeEventsUseCase.observe(group.id).map((event) =>
          event.toList().sortedBy((e) => e.timestamp).reversed.toList());

  Stream<List<SubscriptionService>> getServicesStream() =>
      _observeServicesUseCase.observe(group.id).map(
          (event) => event.toList().sortedBy((element) => element.nameState));

  Stream<Iterable<Pair<Person, num>>> getDebtsStream() =>
      _observeDebtsUseCase.observe(group.id).map((event) {
        return event.map((e) {
          final converted = _convertCurrencyUseCase.launch(
              e.second, Currency.USD().symbol, group.defaultCurrencyState);
          return Pair(e.first, converted);
        }).where((element) => element.second.fmt2dec() != "0");
      });

  void loadGroup() async {
    _getExchangeRatesUseCase.launch();
    emit(SyncingGroup(navIndex));
    _getGroupUseCase
        .launch(group.id)
        .then((value) => emit(GroupLoaded(navIndex)))
        .catchError((err, st) {
      showError(err, st);
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
    }).catchError((err, st) {
      showError(err, st);
    });
  }

  void addPersonToGroup(Person person) {
    emit(AddingPersonToGroup());
    _addPersonToGroupUseCase.launch(group, person).then((value) {
      emit(Main());
    }).catchError((onError, st) {
      showError(onError, st);
    });
  }

  Future updateGroupName(String newName) async {
    group.nameState = newName;
    await _addGroupUseCase.launch(group);
  }

  void retryAddExpense(GroupExpense expense) {
    _addExpenseUseCase.launch(group.id, expense);
  }

  num convertToDefaultCurrency(num amount) {
    // debt is always calculated in USD
    return _convertCurrencyUseCase.launch(
        amount, "usd", group.defaultCurrencyState);
  }

  void updateCurrency(Currency currency) {
    group.defaultCurrencyState = currency.symbol;
    emit(Main());
  }

  void uploadGroupPicture() {
    _uploadGroupPicture.launch(group).then((value) {
      emit(Main());
    }).catchError((err, st) {
      showError(err, st);
    });
  }
}
