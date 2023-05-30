import 'package:billsplit_flutter/data/local/preferences/models/group_notification_setting.dart';
import 'package:billsplit_flutter/data/local/preferences/shared_prefs.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/presentation/features/group/notifications_settings/notification_topics.dart';
import 'package:collection/collection.dart';

class ToggleTopicSubscriptionUseCase {
  final _sharedPrefs = getIt<SharedPrefs>();

  Future launch(String groupId, NotificationTopic topic, bool subscribe) async {
    final GroupNotificationSetting updatedSetting = _sharedPrefs
            .groupNotificationSettings
            .firstWhereOrNull((element) => element.groupId == groupId) ??
        GroupNotificationSetting.fromNewGroup(groupId);

    final groupWithoutUpdatedSetting = _sharedPrefs.groupNotificationSettings
        .where((element) => element.groupId != groupId);

    topic.updateSetting(updatedSetting, subscribe);

    _sharedPrefs.groupNotificationSettings = [
      ...groupWithoutUpdatedSetting,
      updatedSetting
    ];
  }
}
