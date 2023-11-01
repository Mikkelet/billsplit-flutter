import 'package:billsplit_flutter/data/auth/auth_provider.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/presentation/utils/errors_utils.dart';

class ConfirmPhoneNumberUseCase {
  final _authProvider = getIt<AuthProvider>();

  Future launch(String verificationId, String smsCode) async {
    final regex = RegExp("^[0-9]{1,6}\$");
    if (!regex.hasMatch(smsCode)) {
      throw UiException(500, "Invalid code");
    }

    await _authProvider.submitSmsCode(verificationId, smsCode);
  }
}
