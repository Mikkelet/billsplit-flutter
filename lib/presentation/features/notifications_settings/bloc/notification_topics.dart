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
    } else {
      return "New services";
    }
  }

  bool getSetting(GroupNotificationSetting settings) {
    if (this == NotificationTopic.newExpense) {
      return settings.addExpenseSetting;
    } else if (this == NotificationTopic.updateExpense) {
      return settings.updateExpenseSetting;
    } else {
      return settings.newServiceSetting;
    }
  }

  void updateSetting(GroupNotificationSetting settings, bool subscribe) {
    if (this == NotificationTopic.newExpense) {
      settings.addExpenseSetting = subscribe;
    } else if (this == NotificationTopic.updateExpense) {
      settings.updateExpenseSetting = subscribe;
    } else {
      settings.newServiceSetting = subscribe;
    }
  }
}
