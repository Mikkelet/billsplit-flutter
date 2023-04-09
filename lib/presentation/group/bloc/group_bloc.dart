import 'dart:async';

import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/subscription_service.dart';
import 'package:billsplit_flutter/domain/use_cases/get_group_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/observe_events_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/observe_services_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/group/bloc/group_state.dart';

class GroupBloc extends BaseCubit {
  final getGroupUseCase = GetGroupUseCase();
  final _observeEventsUseCase = ObserveEventsUseCase();
  final _observeServicesUseCase = ObserveServicesUseCase();

  StreamSubscription? _servicesStream;

  final Group group;
  GroupPageNav _navIndex = GroupPageNav.events;

  GroupBloc(this.group)
      : super.withState(GroupLoaded(group, GroupPageNav.events));

  Stream<Iterable<Event>> getEventsStream() => _observeEventsUseCase
      .observe(group.id);

  Stream<Iterable<SubscriptionService>> getServicesStream() =>
      _observeServicesUseCase
          .observe(group.id);

  @override
  Future<void> close() {
    _servicesStream?.cancel();
    return super.close();
  }

  void loadGroup() async {
    getGroupUseCase.launch(group.id).catchError((err) {
      showError(err);
      return Map<String, dynamic>.identity();
    });
  }

  void showEvents() => showPage(GroupPageNav.events);

  void showServices() => showPage(GroupPageNav.services);

  void showDebt() => showPage(GroupPageNav.events);

  void showPage(GroupPageNav nav) {
    _navIndex = nav;
    final newState = GroupLoaded(group, _navIndex);
    emit(newState);
  }
}
