import 'package:billsplit_flutter/data/local/preferences/models/group_notification_setting.dart';
import 'package:billsplit_flutter/data/local/preferences/shared_prefs.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/presentation/features/group/notifications_settings/notification_topics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ToggleTopicSubscriptionUseCase {
  final _sharedPrefs = getIt<SharedPrefs>();

  Future launch(String groupId, NotificationTopic topic, bool subscribe) async {
    if (subscribe) {
      await FirebaseMessaging.instance
          .subscribeToTopic(topic.getTopicId(groupId));
    } else {
      await FirebaseMessaging.instance
          .unsubscribeFromTopic(topic.getTopicId(groupId));
    }
    final GroupNotificationSetting updatedSetting = _sharedPrefs
        .groupNotificationSettings
        .firstWhere((element) => element.groupId == groupId);
    final groupWithoutUpdatedSetting = _sharedPrefs.groupNotificationSettings
        .where((element) => element.groupId != groupId);
    if (topic == NotificationTopic.newExpense) {
      updatedSetting.newServiceSetting = subscribe;
    } else if (topic == NotificationTopic.updateExpense) {
      updatedSetting.updateExpenseSetting = subscribe;
    } else {
      updatedSetting.newServiceSetting = subscribe;
    }

    _sharedPrefs.groupNotificationSettings = [
      ...groupWithoutUpdatedSetting,
      updatedSetting
    ];
  }
}
