import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/group.dart';

abstract class GroupsState {}

class GroupsLoaded extends GroupsState {
  final List<Group> groups;

  GroupsLoaded(this.groups);
}

class Loading extends GroupsState {}

class GroupsBloc extends Cubit<GroupsState> {
  final groups = [0, 1, 2, 3, 4, 5].map((e) => Group.mock(e)).toList();

  GroupsBloc() : super(Loading());

  void loadGroups() async {
    emit(Loading());
    await Future.delayed(const Duration(seconds: 2));
    emit(GroupsLoaded(groups));
  }
}
