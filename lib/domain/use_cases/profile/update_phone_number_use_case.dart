import 'package:billsplit_flutter/data/auth/auth_provider.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/presentation/utils/errors_utils.dart';

class UpdatePhoneNumberUseCase {
  final _authProvider = getIt<AuthProvider>();

  Future<void> launch({
    required String phoneNumber,
    required Function(UiException e) onFailed,
    required Function(String verificationId) onCodeSent,
  }) async {
    final prefix = phoneNumber.startsWith("+") ? "" : "+";
    final prefixedPhoneNumber = "$prefix$phoneNumber";

    await _authProvider.updatePhoneNumber(
      phoneNumber: prefixedPhoneNumber,
      onFailed: onFailed,
      onCodeSent: onCodeSent,
    );
  }
}
