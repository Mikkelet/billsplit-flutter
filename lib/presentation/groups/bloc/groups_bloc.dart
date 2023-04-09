import 'package:billsplit_flutter/domain/use_cases/get_groups_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/observe_groups_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/groups/bloc/groups_state.dart';

class GroupsBloc extends BaseCubit {
  final getGroupsUseCase = GetGroupsUseCase();
  final observeGroupsUseCase = ObserveGroupsUseCase();

  GroupsBloc() : super.withState(Loading()) {
    observeGroupsUseCase.observe().listen((groups) {
      final sorted = groups
        ..sort(
          (a, b) {
            final aTimestamp = a.latestEvent?.timestamp ?? 0;
            final bTimestamp = b.latestEvent?.timestamp ?? 0;
            return aTimestamp > bTimestamp ? -1 : 1;
          },
        );
      emit(GroupsLoadedState(sorted));
    }).onError((error) {
      showError(error);
    });
  }

  void loadGroups() async {
    try {
      await getGroupsUseCase.launch();
    } on Error catch (err, _) {
      showError(err);
    } catch (e) {
      print(e);
      showError(Error());
    }
  }
}
