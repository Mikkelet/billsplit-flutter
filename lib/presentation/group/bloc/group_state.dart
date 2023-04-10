import 'package:billsplit_flutter/domain/models/group.dart';
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


class GroupLoaded extends UiState {
  final Group group;
  final GroupPageNav nav;

  GroupLoaded(this.group, this.nav);
}
