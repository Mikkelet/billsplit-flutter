import 'package:billsplit_flutter/domain/models/notification_action.dart';
import 'package:billsplit_flutter/domain/use_cases/friends/get_friends_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/group_invites/sync_group_invites.dart';
import 'package:billsplit_flutter/domain/use_cases/groups/get_local_group_usecase.dart';

class HandleOnMessageOpenedUseCase {
  final _getGroupUseCase = GetLocalGroupUseCase();
  final _getGroupInvitesUseCase = SyncGroupInvitesUseCase();
  final _getFriendsUseCase = GetFriendsUseCase();

  Future<NotificationAction?> launch(Map<String, dynamic> data) async {
    final String? type = data["type"];
    if (type == "group") {
      final String? groupId = data["groupId"];
      if (groupId != null) {
        final group = await _getGroupUseCase.launch(groupId);
        return OpenGroupAction(group: group);
      }
    } else if (type == "groupInvite") {
      await _getGroupInvitesUseCase.launch();
      return OpenGroupInvitesAction();
    } else if (type == "friendInvite") {
      await _getFriendsUseCase.launch();
      return OpenFriendInvitesAction();
    }
    return null;
  }
}
