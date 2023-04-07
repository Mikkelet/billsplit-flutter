import 'package:billsplit_flutter/data/auth/auth_provider.dart';

class InitializeAuthUseCase {
  final _authProvider = AuthProvider.instance;

  Future initialize() async {
    return await _authProvider.init();
  }
}
