import 'package:billsplit_flutter/domain/models/friend.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/use_cases/friends/add_friend_uid_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/friends/get_friend_status_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/friends/respond_to_friend_request_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/groups/get_groups_in_common_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/safe_cubit.dart';
import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:billsplit_flutter/presentation/features/inspect_profile/bloc/inspect_profile_state.dart';

class InspectProfileCubit extends SafeCubit<InspectProfileState> {
  final _getFriendStatusUseCase = GetFriendStatusUseCase();
  final _responseToFriendRequestUseCase = RespondToFriendRequestUseCase();
  final _addFriendUidUseCase = AddFriendUserIdUseCase();
  final _getGroupsInCommonUseCase = GetGroupsInCommonUseCase();

  final Person person;

  InspectProfileCubit(this.person) : super(const InspectProfileState()) {
    _initialiseStatus();
    _loadGroupsInCommon();
  }

  void init() async {
    try {
      safeEmit(state.copyWith(isLoading: true));
      await Future.wait([
        _initialiseStatus(),
        _loadGroupsInCommon(),
      ]);
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.serverError(e.toString())));
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _initialiseStatus() async {
    final status = await _getFriendStatusUseCase.launch(person.uid);
    safeEmit(state.copyWith(status: status));
  }

  Future<void> _loadGroupsInCommon() async {
    final groups = await _getGroupsInCommonUseCase.launch(person);
    safeEmit(state.copyWith(groupsInCommon: groups.toList()));
  }

  void addFriend() async {
    try {
      safeEmit(state.copyWith(isLoading: true));
      await _addFriendUidUseCase.launch(person.uid);
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.serverError(e.toString())));
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }

  void respondToFriendRequest(bool accept) async {
    try {
      safeEmit(state.copyWith(isLoading: true));
      await _responseToFriendRequestUseCase.launch(person, accept);
      _initialiseStatus();
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.serverError(e.toString())));
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }
}
