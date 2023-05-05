import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  late SharedPreferences sharedPrefs;

  Future init() async {
    sharedPrefs = await SharedPreferences.getInstance();
  }

  // hasSeenHoldToAddIndividualExpenseTip
  bool get hasSeenHoldToAddIndividualExpenseTip =>
      sharedPrefs.getBool(hasSeenHoldToAddIndividualExpenseTipKey) ?? false;

  set hasSeenHoldToAddIndividualExpenseTip(bool value) =>
      sharedPrefs.setBool(hasSeenHoldToAddIndividualExpenseTipKey, value);

  // hasSeenPushNotificationPermissionRationale
  bool get hasSeenPushNotificationPermissionRationale =>
      sharedPrefs.getBool(hasSeenPushNotificationPermissionRationaleKey) ??
      false;

  set hasSeenPushNotificationPermissionRationale(bool value) =>
      sharedPrefs.setBool(hasSeenPushNotificationPermissionRationaleKey, value);

  // groupsSubscriptions
  List<String> get groupSubscriptions =>
      sharedPrefs.getStringList(groupSubscriptionsKey) ?? [];

  set groupSubscriptions(List<String> groupIds) =>
      sharedPrefs.setStringList(groupSubscriptionsKey, groupIds);

  void subscribeToGroup(String groupId) {
    groupSubscriptions = [...groupSubscriptions, groupId];
  }

  // groupsUnsubscriptions
  List<String> get groupsUnsubscriptions =>
      sharedPrefs.getStringList(groupUnsubscriptionsKey) ?? [];

  void unsubscribeFromGroup(String groupId) {
    sharedPrefs.setStringList(
        groupUnsubscriptionsKey, [...groupsUnsubscriptions, groupId]);
  }

  static const hasSeenHoldToAddIndividualExpenseTipKey =
      "hasSeenHoldToAddIndividualExpenseTip";
  static const hasSeenPushNotificationPermissionRationaleKey =
      "hasSeenPushNotificationPermissionRationale";
  static const groupSubscriptionsKey = "groupSubscriptionsKey";
  static const groupUnsubscriptionsKey = "groupUnsubscriptionsKey";
}
