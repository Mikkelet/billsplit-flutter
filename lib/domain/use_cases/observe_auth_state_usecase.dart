import 'package:billsplit_flutter/data/auth/auth_provider.dart';
import 'package:billsplit_flutter/di/get_it.dart';

class ObserveAuthStateUseCase {
  final _authProvider = getIt<AuthProvider>();

  Stream<AuthState> observe() {
    return _authProvider.authListener();
  }
}
