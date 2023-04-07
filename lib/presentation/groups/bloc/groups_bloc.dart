import 'package:billsplit_flutter/domain/use_cases/get_groups_usecase.dart';
import 'package:billsplit_flutter/presentation/groups/bloc/groups_state.dart';
import 'package:billsplit_flutter/presentation/utils/response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:billsplit_flutter/domain/models/group.dart';

class GroupsBloc extends Cubit<GroupsState> {
  final getGroupsUseCase = GetGroupsUseCase();
  final groups = [0, 1, 2, 3, 4, 5].map((e) => Group.mock(e)).toList();

  GroupsBloc() : super(LoadingState());

  void loadGroups() async {
    emit(LoadingState());
    final response = await getGroupsUseCase.launch().execute();
    response.foldResponse(onSuccess: (data) {
      if (data is List<Group>) {
        emit(GroupsLoadedState(data..sort(
          (a, b) {
            final aTimestamp = a.latestEvent?.timestamp ?? 0;
            final bTimestamp = b.latestEvent?.timestamp ?? 0;
            return aTimestamp > bTimestamp ? -1 : 1;
          },
        )));
      }
    }, onFailure: (error) {
      print("qqq error=$error");
      emit(FailureState(error));
    });
  }
}
