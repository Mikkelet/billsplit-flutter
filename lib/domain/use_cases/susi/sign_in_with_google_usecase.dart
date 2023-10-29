import 'package:billsplit_flutter/data/auth/auth_provider.dart';
import 'package:billsplit_flutter/di/get_it.dart';

class SignInWithGoogleUseCase {
  final _authProvider = getIt<AuthProvider>();

  Future<void> launch() async {
    return _authProvider.signInWithGoogle();
  }
}