import 'package:billsplit_flutter/domain/models/group.dart';

abstract class NotificationAction {}

class OpenGroupAction extends NotificationAction {
  final Group group;

  OpenGroupAction({required this.group});
}

class OpenGroupInvitesAction extends NotificationAction {}

class OpenFriendInvitesAction extends NotificationAction {}
