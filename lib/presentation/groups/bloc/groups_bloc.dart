import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/use_cases/get_groups_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/observe_groups_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:collection/collection.dart';

class GroupsBloc extends BaseCubit {
  final _getGroupsUseCase = GetGroupsUseCase();
  final _observeGroupsUseCase = ObserveGroupsUseCase();

  GroupsBloc() : super();

  Stream<List<Group>> getGroupStream() =>
      _observeGroupsUseCase.observe().map((event) =>
          event.toList().sortedBy((group) => group.timestamp));

  void loadGroups() async {
    emit(Loading());
    try {
      await _getGroupsUseCase.launch();
    } catch (e) {
      showError(e);
    }
  }
}
