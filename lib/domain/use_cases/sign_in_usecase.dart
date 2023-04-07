import 'package:billsplit_flutter/data/auth/auth_provider.dart';

class SignInUseCase{
  final _authProvider = AuthProvider();

  Future launch(String email, String password) async {
    await _authProvider.signInWithEmail(email, password);
  }
}