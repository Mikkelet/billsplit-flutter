import 'package:billsplit_flutter/domain/models/friend.dart';
import 'package:billsplit_flutter/domain/use_cases/friends/observe_friends_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/group_invites/observe_group_invites_usecase.dart';
import 'package:collection/collection.dart';
import 'package:rxdart/rxdart.dart';

class ObserveNotificationsUseCase {
  final _observeFriendsUseCase = ObserveFriendsUseCase();
  final _observeGroupInvitesUseCase = ObserveGroupInvitesUseCase();

  Stream<int> observe() {
    final Stream<int> friendRequests = _observeFriendsUseCase
        .observe()
        .map((event) => event
            .where((element) => element.status == FriendStatus.requestReceived))
        .map((event) => event.length);

    final Stream<int> groupInvites =
        _observeGroupInvitesUseCase.observe().map((event) => event.length);

    return CombineLatestStream(
        [friendRequests, groupInvites], (values) => values.sum);
  }
}
