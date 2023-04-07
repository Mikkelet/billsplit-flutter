import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/subscription_service.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';

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


class GroupLoaded extends BaseState {
  final Group group;
  final List<Event> events;
  final List<SubscriptionService> services;
  final GroupPageNav nav;

  GroupLoaded(this.group, this.events, this.nav, this.services);
}
