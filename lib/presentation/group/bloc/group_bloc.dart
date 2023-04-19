import 'dart:async';

import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/subscription_service.dart';
import 'package:billsplit_flutter/domain/use_cases/get_group_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/observe_debts_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/observe_events_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/observe_services_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/group/bloc/group_state.dart';
import 'package:billsplit_flutter/utils/pair.dart';

class GroupBloc extends BaseCubit {
  final _getGroupUseCase = GetGroupUseCase();
  final _observeEventsUseCase = ObserveEventsUseCase();
  final _observeServicesUseCase = ObserveServicesUseCase();
  final _observeDebtsUseCase = ObserveDebtsUseCase();

  final Group group;
  GroupPageNav _navIndex = GroupPageNav.events;

  GroupBloc(this.group)
      : super.withState(SyncingGroup(GroupPageNav.events));

  Stream<Iterable<Event>> getEventsStream() =>
      _observeEventsUseCase.observe(group.id);

  Stream<List<SubscriptionService>> getServicesStream() =>
      _observeServicesUseCase.observe(group.id).map((event) => event.toList());

  Stream<Iterable<Pair<Person, num>>> getDebtsStream() =>
      _observeDebtsUseCase.observe(group.id);

  void loadGroup() async {
    emit(SyncingGroup(_navIndex));
    _getGroupUseCase
        .launch(group.id)
        .then((value) => emit(GroupLoaded(_navIndex)))
        .catchError((err) {
      showError(err);
    });
  }

  void showEvents() => showPage(GroupPageNav.events);

  void showServices() => showPage(GroupPageNav.services);

  void showDebt() => showPage(GroupPageNav.events);

  void showPage(GroupPageNav nav) {
    _navIndex = nav;
    final newState = GroupLoaded(_navIndex);
    emit(newState);
  }
}
