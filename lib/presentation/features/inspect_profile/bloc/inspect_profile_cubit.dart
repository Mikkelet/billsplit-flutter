import 'package:billsplit_flutter/domain/models/friend.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/use_cases/friends/add_friend_uid_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/friends/get_friend_status_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/friends/respond_to_friend_request_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/groups/get_groups_in_common_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';

class InspectProfileCubit extends BaseCubit {
  final _getFriendStatusUseCase = GetFriendStatusUseCase();
  final _responseToFriendRequestUseCase = RespondToFriendRequestUseCase();
  final _addFriendUidUseCase = AddFriendUserIdUseCase();
  final _getGroupsInCommonUseCase = GetGroupsInCommonUseCase();

  final Person person;
  FriendStatus? friendStatus;
  Iterable<Group> groupsInCommon = [];

  InspectProfileCubit(this.person) {
    _initialiseStatus();
    _loadGroupsInCommon();
  }

  void _initialiseStatus() {
    showLoading();
    _getFriendStatusUseCase.launch(person.uid).then((status) {
      friendStatus = status;
      update();
    }).catchError((err, stackTrace) {
      showError(err, stackTrace);
    });
  }

  void _loadGroupsInCommon() {
    _getGroupsInCommonUseCase.launch(person).then((value) {
      groupsInCommon = value;
      update();
    });
  }

  void addFriend() {
    showLoading();
    _addFriendUidUseCase.launch(person.uid).then((_) {
      _initialiseStatus();
    }).catchError((err, stackTrace) {
      showError(err, stackTrace);
    });
  }

  void respondToFriendRequest(bool accept) {
    showLoading();
    _responseToFriendRequestUseCase.launch(person, accept).then((_) {
      _initialiseStatus();
    }).catchError((err, stackTrace) {
      showError(err, stackTrace);
    });
  }
}
