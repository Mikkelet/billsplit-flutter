import 'package:billsplit_flutter/data/local/preferences/models/group_notification_setting.dart';

enum NotificationTopic {
  newExpense,
  updateExpense,
  newService;

  String getTopicId(String groupId) {
    if (this == NotificationTopic.newExpense) {
      return "group-new-expense-$groupId";
    } else if (this == NotificationTopic.updateExpense) {
      return "group-update-expense-$groupId";
    }
    return "group-new-service-$groupId";
  }

  String getTopicName() {
    if (this == NotificationTopic.newExpense) {
      return "New expenses";
    } else if (this == NotificationTopic.updateExpense) {
      return "Expense updates";
    }
    return "New services";
  }

  bool getSetting(GroupNotificationSetting settings) {
    if (this == NotificationTopic.newExpense) {
      return settings.addExpenseSetting;
    } else if (this == NotificationTopic.updateExpense) {
      return settings.updateExpenseSetting;
    }
    return settings.newServiceSetting;
  }
}
