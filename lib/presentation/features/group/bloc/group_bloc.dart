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
import 'package:billsplit_flutter/domain/use_cases/groups/observe_groups_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/services/observe_services_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/safe_cubit.dart';
import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:billsplit_flutter/presentation/features/group/bloc/group_state.dart';
import 'package:billsplit_flutter/presentation/mutable_state.dart';
import 'package:billsplit_flutter/utils/pair.dart';
import 'package:collection/collection.dart';

import '../../../../domain/use_cases/groups/observe_group_usecase.dart';


class GroupBloc extends SafeCubit<GroupState> {
  final _getGroupUseCase = GetGroupUseCase();
  final _observeEventsUseCase = ObserveEventsUseCase();
  final _observeServicesUseCase = ObserveServicesUseCase();
  final _observeDebtsUseCase = ObserveDebtsUseCase();
  final _addExpenseUseCase = AddEventUseCase();
  final _observeGroupUseCase = ObserveGroupUseCase();
  final _getExchangeRatesUseCase = GetExchangeRatesUseCase();

  final String groupId;

  GroupBloc(this.groupId) : super(GroupState());

  void init() {
    _observeGroupUseCase.invoke(groupId).listen((group) {
      safeEmit(state.copyWith(group: group, isLoading: false));
    });
  }

  Stream<List<Event>> getEventsStream() async* {
    await for (final events in _observeEventsUseCase.observe(groupId)) {
      num sortBy(Event event) {
        if (state.sortBy == SortEvents.added) return event.timestamp;
        if (event is GroupExpense) return event.dateState.value.millisecondsSinceEpoch;
        return event.timestamp;
      }
      yield events
          .sortedBy(sortBy)
          .reversed
          .toList();
    }
  }


  Stream<List<SubscriptionService>> getServicesStream() async* {
    await for (final services in _observeServicesUseCase.observe(groupId)) {
      yield services.toList().sortedBy((element) => element.nameState.value);
    }
  }

  Stream<Iterable<Pair<Person, num>>> getDebtsStream() async* {
    if (state.group != null) {
      yield* _observeDebtsUseCase.observe(state.requireGroup);
    }
  }


  void loadGroup() async {
    try {
      safeEmit(state.copyWith(isLoading: true));
      await _getExchangeRatesUseCase.launch();
      await _getGroupUseCase.launch(groupId);
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.serverError(e.toString())));
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }

  void showEvents() => showPage(GroupPageNav.events);

  void showPage(GroupPageNav nav) {
    safeEmit(state.copyWith(groupNav: nav));
  }

  void retryAddExpense(GroupExpense expense) {
    _addExpenseUseCase.launch(state.requireGroup, expense);
  }

  void changeSort(SortEvents sortEvents) {
    safeEmit(state.copyWith(sortBy: sortEvents));
  }
}
