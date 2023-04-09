import 'person.dart';

enum FriendStatus {
  requestReceived,
  requestSent,
  accepted;
}

class Friend {
  final Person person;
  final FriendStatus status;

  Friend(this.person, this.status);
}
