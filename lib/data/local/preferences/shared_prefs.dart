import 'dart:convert';

import 'package:billsplit_flutter/data/local/preferences/models/group_notification_setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  late SharedPreferences _sharedPrefs;

  Future init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  // hasSeenHoldToAddIndividualExpenseTip
  bool get hasSeenHoldToAddIndividualExpenseTip =>
      _sharedPrefs.getBool(hasSeenHoldToAddIndividualExpenseTipKey) ?? false;

  set hasSeenHoldToAddIndividualExpenseTip(bool value) =>
      _sharedPrefs.setBool(hasSeenHoldToAddIndividualExpenseTipKey, value);

  // hasSeenPushNotificationPermissionRationale
  bool get hasSeenPushNotificationPermissionRationale =>
      _sharedPrefs.getBool(hasSeenPushNotificationPermissionRationaleKey) ??
      false;

  set hasSeenPushNotificationPermissionRationale(bool value) => _sharedPrefs
      .setBool(hasSeenPushNotificationPermissionRationaleKey, value);

  // get Group Notification settings
  Iterable<GroupNotificationSetting> get groupNotificationSettings {
    final settingsJson = _sharedPrefs.getStringList(groupSubscriptionsKey);
    if (settingsJson == null) return [];
    return settingsJson
        .map((e) => GroupNotificationSetting.fromJson(jsonDecode(e)));
  }

  set groupNotificationSettings(Iterable<GroupNotificationSetting> settings) {
    final settingsJson = settings.map((e) => jsonEncode(e.toJson()));
    _sharedPrefs.setStringList(groupSubscriptionsKey, settingsJson.toList());
  }

  // exchange rates
  Map<String, num> get latestExchangeRates {
    final json = _sharedPrefs.getString(latestExchangeRatesKey) ?? "";
    return jsonDecode(json) as Map<String, num>;
  }

  set latestExchangeRates(Map<String, num> rates) {
    _sharedPrefs.setString(latestExchangeRatesKey, jsonEncode(rates));
  }

  static const hasSeenHoldToAddIndividualExpenseTipKey =
      "hasSeenHoldToAddIndividualExpenseTip";
  static const hasSeenPushNotificationPermissionRationaleKey =
      "hasSeenPushNotificationPermissionRationale";
  static const groupSubscriptionsKey = "groupNotificationSettings";
  static const latestExchangeRatesKey = "latestExchangeRates";
}
