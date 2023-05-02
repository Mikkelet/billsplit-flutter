import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  late SharedPreferences sharedPrefs;

  Future init() async {
    sharedPrefs = await SharedPreferences.getInstance();
  }

  // hasSeenHoldToAddIndividualExpenseTip
  bool get hasSeenHoldToAddIndividualExpenseTip {
    return sharedPrefs.getBool(hasSeenHoldToAddIndividualExpenseTipKey) ??
        false;
  }

  set hasSeenHoldToAddIndividualExpenseTip(bool value) {
    sharedPrefs.setBool(hasSeenHoldToAddIndividualExpenseTipKey, value);
  }

  //

  static const hasSeenHoldToAddIndividualExpenseTipKey =
      "hasSeenHoldToAddIndividualExpenseTip";
}
