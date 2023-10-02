import 'package:billsplit_flutter/data/remote/network_client.dart';
import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/use_cases/sign_out_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/update_display_name_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProfileCubit extends BaseCubit {
  final _signOutUseCase = SignOutUseCase();
  final _updateDisplayNameUseCase = UpdateDisplayNameUseCase();


  void signOut() {
    showLoading();
    _signOutUseCase.launch().then((value) {

    }).catchError((error, st) {
      showError(error, st);
    });
  }

  Future updateDisplayName(String newName) async {
    await _updateDisplayNameUseCase.launch(newName);
    user.nameState = newName;
  }

  void updateCurrency(Currency currency) {
    sharedPrefs.userPrefDefaultCurrency = currency.symbol;
    emit(Main());
  }

  Future<String> syncVersion() async {
    final apiVersion = NetworkClient.apiVersion;
    final packageInfo = await PackageInfo.fromPlatform();
    final appVersion = packageInfo.buildNumber;
    return "Version ${packageInfo.version} ($appVersion), apiVersion $apiVersion";
  }
}
