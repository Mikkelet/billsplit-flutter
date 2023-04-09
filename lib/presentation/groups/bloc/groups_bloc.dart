import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/use_cases/get_groups_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/observe_groups_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';

class GroupsBloc extends BaseCubit {
  final _getGroupsUseCase = GetGroupsUseCase();
  final _observeGroupsUseCase = ObserveGroupsUseCase();

  GroupsBloc() : super();

  Stream<Iterable<Group>> getGroupStream() =>
      _observeGroupsUseCase.observe().map((event) => event
        ..sort(
          (a, b) {
            final aTimestamp = a.latestEvent?.timestamp ?? 0;
            final bTimestamp = b.latestEvent?.timestamp ?? 0;
            return aTimestamp > bTimestamp ? -1 : 1;
          },
        ));

  void loadGroups() async {
    try {
      await _getGroupsUseCase.launch();
    } on Error catch (err, _) {
      showError(err);
    } catch (e) {
      print(e);
      showError(Error());
    }
  }
}
