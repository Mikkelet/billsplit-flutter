import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/use_cases/get_friends_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/get_groups_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/observe_groups_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:collection/collection.dart';

class GroupsBloc extends BaseCubit {
  final _getGroupsUseCase = GetGroupsUseCase();
  final _getFriendsUseCase = GetFriendsUseCase();
  final _observeGroupsUseCase = ObserveGroupsUseCase();

  GroupsBloc() : super();

  Stream<List<Group>> getGroupStream() => _observeGroupsUseCase
      .observe()
      .map((event) => event.toList().sortedBy((group) => group.timestamp));

  void loadProfile() async {
    emit(Loading());
    Future.value([_getFriendsUseCase.launch(), _getGroupsUseCase.launch()])
        .then((value) {
      emit(Main());
    }).catchError((error) {
      showError(error);
    });
  }

  Future refreshGroups() async {
    try {
      await _getGroupsUseCase.launch();
    } catch (e) {
      showError(e);
    }
  }
}
