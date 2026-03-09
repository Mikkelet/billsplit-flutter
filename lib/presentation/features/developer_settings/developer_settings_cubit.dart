import 'package:billsplit_flutter/data/local/preferences/shared_prefs.dart';
import 'package:billsplit_flutter/presentation/base/bloc/safe_cubit.dart';

class DeveloperSettingsCubit extends SafeCubit<int> {
  final SharedPrefs sharedPrefs;

  DeveloperSettingsCubit(this.sharedPrefs) : super(0);

  void resetGuides() {
    sharedPrefs.hasSeenChoosePayerGuide = false;
    sharedPrefs.hasSeenScannerDisclaimer = false;
    sharedPrefs.hasDeletedSharedExpense = false;
    sharedPrefs.hasSeenHoldToAddIndividualExpenseTip = false;
    sharedPrefs.hasSeenSharedExpenseGuide = false;
  }
}
