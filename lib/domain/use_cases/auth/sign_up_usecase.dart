import 'package:billsplit_flutter/data/auth/auth_provider.dart';
import 'package:billsplit_flutter/di/get_it.dart';

class SignUpWithEmailUseCase {
  final _authProvider = getIt<AuthProvider>();

  Future launch(String email, String password) async {
    await _authProvider.signUpWithEmail(email, password);
  }
}
