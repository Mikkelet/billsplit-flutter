import 'person.dart';

enum FriendStatus {
  yourself,
  notFriends,
  requestReceived,
  requestSent,
  accepted;

  String get dbValue {
    if (this == FriendStatus.accepted) return "accepted";
    return "pending";
  }
}

class Friend {
  final Person person;
  final FriendStatus status;

  Friend(this.person, this.status);
}
