import 'package:billsplit_flutter/domain/use_cases/get_groups_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/groups/bloc/groups_state.dart';

class GroupsBloc extends BaseCubit {
  final getGroupsUseCase = GetGroupsUseCase();

  GroupsBloc() : super.withState(Loading());

  void loadGroups() async {
    showLoading();
    getGroupsUseCase.launch().then((data) {
      final sorted = data
        ..sort(
          (a, b) {
            final aTimestamp = a.latestEvent?.timestamp ?? 0;
            final bTimestamp = b.latestEvent?.timestamp ?? 0;
            return aTimestamp > bTimestamp ? -1 : 1;
          },
        );
      emit(GroupsLoadedState(sorted));
    }).catchError((err) {
      showError(err);
    });
  }
}
