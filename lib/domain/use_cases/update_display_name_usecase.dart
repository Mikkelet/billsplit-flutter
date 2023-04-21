import 'package:billsplit_flutter/data/auth/auth_provider.dart';
import 'package:billsplit_flutter/di/get_it.dart';

class UpdateDisplayNameUseCase {
  final _authProvider = getIt<AuthProvider>();

  Future launch(String name) async {
    await _authProvider.updateUserName(name);
  }
}
