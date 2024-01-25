import 'package:billsplit_flutter/data/auth/auth_provider.dart';
import 'package:billsplit_flutter/di/get_it.dart';

class SignInGuestUseCase {
  final _authProvider = getIt<AuthProvider>();

  Future launch() async {
    await _authProvider.signUpAsGuest();
  }
}
