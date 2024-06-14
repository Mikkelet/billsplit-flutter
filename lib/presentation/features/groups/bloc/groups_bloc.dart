import 'dart:async';

import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/use_cases/events/observe_debts_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/friends/get_friends_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/group_invites/sync_group_invites.dart';
import 'package:billsplit_flutter/domain/use_cases/groups/get_groups_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/groups/observe_groups_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/notifications/observe_notifications_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:collection/collection.dart';

class GroupsBloc extends BaseCubit {
  final _getGroupsUseCase = GetGroupsUseCase();
  final _getFriendsUseCase = GetFriendsUseCase();
  final _observeGroupsUseCase = ObserveGroupsUseCase();
  final _observeDebtsUseCase = ObserveDebtsUseCase();
  final _getGroupInvitesUseCase = SyncGroupInvitesUseCase();
  final _observeNotificationsUseCase = ObserveNotificationsUseCase();

  Stream<int> get notificationStream => _observeNotificationsUseCase.observe();
  final Map<String, num> _debts = {};

  Stream<List<Group>> getGroupStream() =>
      _observeGroupsUseCase.observe().map((event) => event
              .sortedBy<num>((group) => group.lastUpdatedState.value)
              .reversed
              .map((e) {
            _getDebts(e);
            return e;
          }).toList());

  Future loadProfile() async {
    try {
      await Future.wait([
        _getFriendsUseCase.launch(),
        _getGroupsUseCase.launch(),
        _getGroupInvitesUseCase.launch(),
      ]);
    } catch (err, stackTrace) {
      showError(err, stackTrace);
    }
  }

  void _getDebts(Group group) async {
    final debtsResult = await _observeDebtsUseCase.observe(group).first;
    if (debtsResult.isEmpty) return;
    if (debtsResult.length > 1) {
      _debts[group.id] = debtsResult.map((e) => e.second).sum;
    } else {
      _debts[group.id] = debtsResult.first.second;
    }
  }

  num getDebtForGroup(Group group) {
    return _debts[group.id] ?? 0;
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

  Iterable<Person> peopleInGroup(Group group) {
    // peopleState only contains a copy of the logged in user,
    // but we need the user instance from AuthProvider
    final peopleWithoutUser = group.peopleState.value.where((element) => element != user);
    return [user, ...peopleWithoutUser];
  }
}
