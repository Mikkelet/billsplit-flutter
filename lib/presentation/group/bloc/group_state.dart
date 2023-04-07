import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/subscription_service.dart';

enum GroupPageNav {
  events,
  services,
  debt;

  static GroupPageNav fromIndex(int index) {
    switch (index) {
      case 2:
        return GroupPageNav.debt;
      case 1:
        return GroupPageNav.services;
      default:
        return GroupPageNav.events;
    }
  }
}

abstract class GroupState {}

class GroupLoaded extends GroupState {
  final Group group;
  final List<Event> events;
  final List<SubscriptionService> services;
  final GroupPageNav nav;

  GroupLoaded(this.group, this.events, this.nav, this.services);
}

class Loading extends GroupState {}

class LoadingFailed extends GroupState {}
