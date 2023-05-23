import 'package:billsplit_flutter/data/auth/auth_provider.dart';
import 'package:billsplit_flutter/di/get_it.dart';

class ObserveAuthStateUseCase {
  final _authProvider = getIt<AuthProvider>();

  Stream<String?> observe() {
    return _authProvider.authListener().asyncMap((event) async {
      if (event == null) {
        await Future.delayed(const Duration(seconds: 1));
        return event;
      }
      return event;
    });
  }
}
