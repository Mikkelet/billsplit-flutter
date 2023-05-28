import '../../base/bloc/base_cubit.dart';

class DeveloperSettingsCubit extends BaseCubit {
  void resetGuides() {
    sharedPrefs.hasSeenChoosePayerGuide = false;
    sharedPrefs.hasSeenScannerDisclaimer = false;
    sharedPrefs.hasDeletedSharedExpense = false;
    sharedPrefs.hasSeenHoldToAddIndividualExpenseTip = false;
    sharedPrefs.hasSeenSharedExpenseGuide = false;
  }

}
