import 'package:billsplit_flutter/domain/models/group.dart';

abstract class GroupsState {}

class GroupsLoadedState extends GroupsState {
  final List<Group> groups;

  GroupsLoadedState(this.groups);
}

class FailureState extends GroupsState {
  final Exception exception;

  FailureState(this.exception);
}

class LoadingState extends GroupsState {}