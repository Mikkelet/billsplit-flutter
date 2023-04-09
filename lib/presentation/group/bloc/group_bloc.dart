import 'dart:async';

import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/subscription_service.dart';
import 'package:billsplit_flutter/domain/use_cases/get_group_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/observe_events_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/observe_services_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/group/bloc/group_state.dart';

class GroupBloc extends BaseCubit {
  final getGroupUseCase = GetGroupUseCase();
  final observeEventsUseCase = ObserveEventsUseCase();
  final observeServicesUseCase = ObserveServicesUseCase();

  StreamSubscription? _eventsStream;
  StreamSubscription? _servicesStream;

  final Group group;
  List<Event> _events = [];
  List<SubscriptionService> _services = [];
  GroupPageNav _navIndex = GroupPageNav.events;

  GroupBloc(this.group) : super.withState(Loading()) {
    _eventsStream = observeEventsUseCase.observe(group.id).listen((events) {
      _events = events.toList();
      showPage(_navIndex);
    });
    _servicesStream = observeServicesUseCase.observe(group.id).listen((event) {
      _services = event.toList();
      showPage(_navIndex);
    });
  }

  @override
  Future<void> close() {
    _eventsStream?.cancel();
    _servicesStream?.cancel();
    return super.close();
  }

  void loadGroup() async {
    showLoading();
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
    final newState = GroupLoaded(group, _events, _navIndex, _services);
    emit(newState);
  }
}
