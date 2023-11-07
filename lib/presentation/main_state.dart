import 'package:billsplit_flutter/domain/models/app_version.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/notification_action.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';

class ShowNotificationPermissionRationale extends Main {}

class GroupOpenedFromNotification extends Main {
  final Group group;

  GroupOpenedFromNotification(this.group);
}

class NotificationActionEvent extends Main {
  final NotificationAction notificationAction;

  NotificationActionEvent({required this.notificationAction});
}

class MandatoryUpdateState extends Main {
  final AppVersion appVersion;

  MandatoryUpdateState(this.appVersion);
}
