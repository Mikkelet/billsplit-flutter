import 'dart:async';

import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/subscription_service.dart';
import 'package:billsplit_flutter/domain/use_cases/currency/get_exchange_rates_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/events/add_event_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/events/observe_debts_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/events/observe_events_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/groups/get_group_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/services/observe_services_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_state.dart';
import 'package:billsplit_flutter/presentation/mutable_state.dart';
import 'package:billsplit_flutter/utils/pair.dart';
import 'package:collection/collection.dart';

enum SortEvents {
  added,
  specified;
}

class GroupBloc extends BaseCubit {
  final _getGroupUseCase = GetGroupUseCase();
  final _observeEventsUseCase = ObserveEventsUseCase();
  final _observeServicesUseCase = ObserveServicesUseCase();
  final _observeDebtsUseCase = ObserveDebtsUseCase();
  final _addExpenseUseCase = AddEventUseCase();
  final _getExchangeRatesUseCase = GetExchangeRatesUseCase();

  final Group group;
  SortEvents _eventSortBy = SortEvents.added;
  GroupPageNav navPage = GroupPageNav.events;
  final isSyncing = false.obs();

  GroupBloc(this.group) : super.withState(GroupState(GroupPageNav.events));

  Stream<List<Event>> getEventsStream() =>
      _observeEventsUseCase.observe(group.id).map((event) => event
          .sortedBy((e) {
            if (_eventSortBy == SortEvents.added) {
              return e.timestamp;
            } else if (e is GroupExpense) {
              return e.dateState.value.millisecondsSinceEpoch;
            } else {
              return e.timestamp;
            }
          })
          .reversed
          .toList());

  Stream<List<SubscriptionService>> getServicesStream() =>
      _observeServicesUseCase.observe(group.id).map((event) =>
          event.toList().sortedBy((element) => element.nameState.value));

  Stream<Iterable<Pair<Person, num>>> getDebtsStream() =>
      _observeDebtsUseCase.observe(group);

  void loadGroup() async {
    isSyncing.value = true;
    _getExchangeRatesUseCase.launch();
    _getGroupUseCase.launch(group.id).then((_) {
      isSyncing.value = false;
    }).catchError((err, st) {
      showError(err, st);
    });
  }

  void showEvents() => showPage(GroupPageNav.events);

  void showPage(GroupPageNav nav) {
    navPage = nav;
    update();
  }

  void retryAddExpense(GroupExpense expense) {
    _addExpenseUseCase.launch(group, expense);
  }

  void changeSort(SortEvents sortEvents) {
    _eventSortBy = sortEvents;
    update();
  }

  @override
  void update() {
    emit(GroupState(navPage));
  }

  SortEvents get sortedBy => _eventSortBy;
}
