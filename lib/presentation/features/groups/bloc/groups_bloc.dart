import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/repositories/auth_repository.dart';
import 'package:billsplit_flutter/domain/use_cases/events/observe_debts_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/friends/get_friends_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/group_invites/sync_group_invites.dart';
import 'package:billsplit_flutter/domain/use_cases/groups/get_groups_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/groups/observe_groups_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/notifications/observe_notifications_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/safe_cubit.dart';
import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:collection/collection.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'groups_state.dart';

class GroupsBloc extends SafeCubit<GroupsState> {
  final AuthRepository _authRepository;

  final _getGroupsUseCase = GetGroupsUseCase();
  final _getFriendsUseCase = GetFriendsUseCase();
  final _observeGroupsUseCase = ObserveGroupsUseCase();
  final _observeDebtsUseCase = ObserveDebtsUseCase();
  final _getGroupInvitesUseCase = SyncGroupInvitesUseCase();
  final _observeNotificationsUseCase = ObserveNotificationsUseCase();

  Person get user => _authRepository.loggedInUser;

  late final StreamSubscription<Iterable<Group>> _groupSubscription;
  late final StreamSubscription<int> _notificationStreamSubscription;

  final Map<String, num> _debts = {};

  GroupsBloc(this._authRepository) : super(const GroupsState());

  void init() async {
    _groupSubscription = _observeGroupsUseCase
        .observe()
        .map((groups) {
          return groups.sortedBy<num>((group) => group.lastUpdatedState.value).reversed.map((e) {
            _getDebts(e);
            return e;
          });
        })
        .listen((groups) {
          safeEmit(state.copyWith(groups: groups.toList(), isLoading: false));
        });

    _notificationStreamSubscription = _observeNotificationsUseCase.observe().listen(
      (notifications) {},
    );
  }

  Future<void> loadProfile() async {
    try {
      safeEmit(state.copyWith(isLoading: true));
      await Future.wait([
        _getFriendsUseCase.launch(),
        _getGroupsUseCase.launch(),
        _getGroupInvitesUseCase.launch(),
      ]);
    } catch (err, stackTrace) {
      logError(err, stackTrace);
      safeEmit(state.copyWith(error: SplitsbyError.serverError(err.toString())));
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

  Future<String> getGreeting() async {
    final now = DateTime.now();
    final morning = DateTime.now().copyWith(hour: 5, minute: 0);
    final noon = DateTime.now().copyWith(hour: 12, minute: 0);
    final evening = DateTime.now().copyWith(hour: 18, minute: 0);
    final name = user.displayName.replaceRange(
      0,
      1,
      user.displayName[0].toUpperCase(),
    );
    final token = await FirebaseMessaging.instance.getToken();
    if (now.isAfter(morning) && now.isBefore(noon)) {
      return "Good morning, $token";
    } else if (now.isAfter(noon) && now.isBefore(evening)) {
      return "Good afternoon, $token";
    } else {
      return "Good evening, $token";
    }
  }

  List<Person> peopleInGroup(Group group) {
    // peopleState only contains a copy of the logged in user,
    // but we need the user instance from AuthProvider
    final peopleWithoutUser = group.peopleState.value.where(
      (element) => element != user,
    );
    return [user, ...peopleWithoutUser];
  }

  @override
  Future<void> close() async {
    await _groupSubscription.cancel();
    await _notificationStreamSubscription.cancel();
    return super.close();
  }
}
