import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/use_cases/get_friends_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/get_groups_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/observe_debts_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/observe_groups_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:collection/collection.dart';

class GroupsBloc extends BaseCubit {
  final _getGroupsUseCase = GetGroupsUseCase();
  final _getFriendsUseCase = GetFriendsUseCase();
  final _observeGroupsUseCase = ObserveGroupsUseCase();
  final _observeDebtsUseCase = ObserveDebtsUseCase();

  GroupsBloc() : super();

  Stream<List<Group>> getGroupStream() =>
      _observeGroupsUseCase.observe().map((event) => event
          .sortedBy<num>((group) => group.latestEventState?.timestamp ?? 0)
          .reversed
          .toList());

  void loadProfile() async {
    emit(Loading());
    Future.value([_getFriendsUseCase.launch(), _getGroupsUseCase.launch()])
        .then((value) {
      emit(Main());
    }).catchError((error, st) {
      showError(error, st);
    });
  }

  Stream<num> getDebtsStream(Group group) =>
      _observeDebtsUseCase.observe(group).map((event) {
        if (event.isEmpty) {
          return 0;
        }
        if (event.length > 1) {
          return event.map((e) => e.second).sum;
        }
        return event.first.second;
      });

  Future refreshGroups() async {
    try {
      await _getGroupsUseCase.launch();
    } catch (e, st) {
      showError(e, st);
    }
  }
}
