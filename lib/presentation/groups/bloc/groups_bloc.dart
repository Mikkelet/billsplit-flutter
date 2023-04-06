import 'package:billsplit_flutter/domain/use_cases/get_groups_usecase.dart';
import 'package:billsplit_flutter/presentation/utils/response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/group.dart';

abstract class GroupsState {}

class GroupsLoaded extends GroupsState {
  final List<Group> groups;

  GroupsLoaded(this.groups);
}

class Loading extends GroupsState {}

class GroupsBloc extends Cubit<GroupsState> {
  final getGroupsUseCase = GetGroupsUseCase();
  final groups = [0, 1, 2, 3, 4, 5].map((e) => Group.mock(e)).toList();

  GroupsBloc() : super(Loading());

  void loadGroups() async {
    emit(Loading());
    final response = await getGroupsUseCase.launch().execute();
    response.foldResponse(onSuccess: (data) {
      if(data is List<Group>) {
        emit(GroupsLoaded(data));
      }
    }, onFailure: (error) {
      print("Error");
    });
  }
}
