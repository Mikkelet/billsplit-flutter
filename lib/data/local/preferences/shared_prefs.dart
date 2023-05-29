import 'dart:convert';

import 'package:billsplit_flutter/data/local/preferences/models/group_notification_setting.dart';
import 'package:billsplit_flutter/data/local/preferences/models/recent_currency.dart';
import 'package:billsplit_flutter/domain/models/currency.dart';
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
    if (json.isEmpty) return <String, num>{};
    final decode = jsonDecode(json);
    final cast = (decode as Map).map(
        (key, value) => MapEntry<String, num>(key as String, value as num));

    return cast;
  }

  set latestExchangeRates(Map<String, num> rates) {
    _sharedPrefs.setString(latestExchangeRatesKey, jsonEncode(rates));
  }

  // user preference: default currency
  String get userPrefDefaultCurrency =>
      _sharedPrefs.getString(userPrefDefaultCurrencyKey) ?? "usd";

  set userPrefDefaultCurrency(String symbol) =>
      _sharedPrefs.setString(userPrefDefaultCurrencyKey, symbol);

  // recently picked currencies
  Iterable<Currency> get recentCurrencies {
    final lsJson = _sharedPrefs.getStringList(recentCurrenciesKey) ?? [];
    if (lsJson.isEmpty) return [];
    final recentSorted =
        lsJson.map((e) => RecentCurrency.fromJson(jsonDecode(e))).toList();
    return recentSorted.map((e) => Currency(symbol: e.symbol, rate: 0));
  }

  set recentCurrencies(Iterable<Currency> currencies) {
    final currencyWithTimestamp = currencies.map((currency) =>
        RecentCurrency(currency.symbol, DateTime.now().millisecondsSinceEpoch));
    final encoded = currencyWithTimestamp.map((e) => jsonEncode(e.toJson()));
    _sharedPrefs.setStringList(recentCurrenciesKey, encoded.toList());
  }

  // hasDeletedSharedExpenseKey
  bool get hasDeletedSharedExpense =>
      _sharedPrefs.getBool(hasDeletedSharedExpenseKey) ?? false;

  set hasDeletedSharedExpense(bool value) =>
      _sharedPrefs.setBool(hasDeletedSharedExpenseKey, value);

  // hasSeenScannerDisclaimer
  bool get hasSeenScannerDisclaimer =>
      _sharedPrefs.getBool(hasSeenScannerDisclaimerKey) ?? false;

  set hasSeenScannerDisclaimer(bool value) =>
      _sharedPrefs.setBool(hasSeenScannerDisclaimerKey, value);

  // hasSeenChoosePayerGuide
  bool get hasSeenChoosePayerGuide =>
      _sharedPrefs.getBool(hasSeenChoosePayerGuideKey) ?? false;

  set hasSeenChoosePayerGuide(bool value) =>
      _sharedPrefs.setBool(hasSeenChoosePayerGuideKey, value);

  // hasSeenChoosePayerGuide
  bool get hasSeenSharedExpenseGuide =>
      _sharedPrefs.getBool(hasSeenSharedExpenseGuideKey) ?? false;

  set hasSeenSharedExpenseGuide(bool value) =>
      _sharedPrefs.setBool(hasSeenSharedExpenseGuideKey, value);

  // Keys
  static const hasSeenHoldToAddIndividualExpenseTipKey =
      "hasSeenHoldToAddIndividualExpenseTip";
  static const hasSeenPushNotificationPermissionRationaleKey =
      "hasSeenPushNotificationPermissionRationale";
  static const groupSubscriptionsKey = "groupNotificationSettings";
  static const recentCurrenciesKey = "recentCurrencies";
  static const latestExchangeRatesKey = "latestExchangeRates";
  static const userPrefDefaultCurrencyKey = "defaultCurrency";
  static const hasDeletedSharedExpenseKey = "hasDeletedSharedExpense";
  static const hasSeenScannerDisclaimerKey = "hasSeenScannerDisclaimer";
  static const hasSeenChoosePayerGuideKey = "hasSeenChoosePayerGuide";
  static const hasSeenSharedExpenseGuideKey = "hasSeenSharedExpenseGuide";
}
