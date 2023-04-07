import 'package:billsplit_flutter/data/auth/auth_provider.dart';

class ObserveAuthStateUseCase {
  final _authProvider = AuthProvider.instance;

  Stream<String?> observe(){
    return _authProvider.authListener();
  }
}