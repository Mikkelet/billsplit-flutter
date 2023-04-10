import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/use_cases/get_groups_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/observe_groups_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:collection/collection.dart';

class GroupsBloc extends BaseCubit {
  final _getGroupsUseCase = GetGroupsUseCase();
  final _observeGroupsUseCase = ObserveGroupsUseCase();

  GroupsBloc() : super();

  Stream<Iterable<Group>> getGroupStream() =>
      _observeGroupsUseCase.observe().map((event) =>
          event.toList().sortedBy((group) => group.timestamp));

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
