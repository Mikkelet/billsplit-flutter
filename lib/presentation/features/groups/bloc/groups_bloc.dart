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

  Map<String, num> debts = {};

  Stream<List<Group>> getGroupStream() =>
      _observeGroupsUseCase.observe().map((event) => event
              .sortedBy<num>((group) => group.latestEventState?.timestamp ?? 0)
              .reversed
              .map((e) {
            _getDebtsStream(e);
            return e;
          }).toList());

  void loadProfile() async {
    emit(Loading());
    Future.value([_getFriendsUseCase.launch(), _getGroupsUseCase.launch()])
        .then((value) {
      emit(Main());
    }).catchError((error, st) {
      showError(error, st);
    });
  }

  void _getDebtsStream(Group group) async {
    final debtsResult = await _observeDebtsUseCase.observe(group).first;
    if (debtsResult.isEmpty) return;
    if (debtsResult.length > 1) {
      debts[group.id] = debtsResult.map((e) => e.second).sum;
    } else {
      debts[group.id] = debtsResult.first.second;
    }
  }

  num getDebtForGroup(Group group) {
    return debts[group.id] ?? 0;
  }

  Future refreshGroups() async {
    try {
      await _getGroupsUseCase.launch();
    } catch (e, st) {
      showError(e, st);
    }
  }

  String getGreeting() {
    final now = DateTime.now();
    final morning = DateTime.now().copyWith(hour: 5, minute: 0);
    final noon = DateTime.now().copyWith(hour: 12, minute: 0);
    final evening = DateTime.now().copyWith(hour: 18, minute: 0);
    final name =
        user.displayName.replaceRange(0, 1, user.displayName[0].toUpperCase());
    if (now.isAfter(morning) && now.isBefore(noon)) {
      return "Good morning, $name";
    } else if (now.isAfter(noon) && now.isBefore(evening)) {
      return "Good afternoon, $name";
    } else {
      return "Good evening, $name";
    }
  }
}
