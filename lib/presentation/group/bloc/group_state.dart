import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';

enum GroupPageNav {
  events,
  services,
  debt,
  settings;

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

abstract class GroupState extends Main {
  final GroupPageNav nav;

  GroupState(this.nav);
}

class SyncingGroup extends GroupState {
  SyncingGroup(super.nav);
}

class GroupLoaded extends GroupState {
  GroupLoaded(super.nav);
}

class GroupLeft extends Main{}

class DebtAdded extends Main{}

class AddingPersonToGroup extends Main{}

enum EditGroupNameState {
  display,
  isEditing,
  isUpdating,
}