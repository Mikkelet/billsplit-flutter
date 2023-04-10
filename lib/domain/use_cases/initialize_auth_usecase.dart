import 'package:billsplit_flutter/data/auth/auth_provider.dart';
import 'package:billsplit_flutter/di/get_it.dart';

class InitializeAuthUseCase {
  final _authProvider = getIt<AuthProvider>();

  Future initialize() async {
    return await _authProvider.init();
  }
}
