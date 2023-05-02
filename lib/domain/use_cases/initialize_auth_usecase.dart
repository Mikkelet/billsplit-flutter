import 'package:billsplit_flutter/data/auth/auth_provider.dart';
import 'package:billsplit_flutter/data/firebase/firebase.dart';
import 'package:billsplit_flutter/data/local/preferences/shared_prefs.dart';
import 'package:billsplit_flutter/data/remote/storage/storage_provider.dart';
import 'package:billsplit_flutter/di/get_it.dart';

class InitializeAuthUseCase {
  final _firebase = getIt<FirebaseProvider>();
  final _authProvider = getIt<AuthProvider>();
  final _storageProvider = getIt<FirebaseStorageProvider>();
  final _sharedPrefs = getIt<SharedPrefs>();

  Future initialize() async {
    await _firebase.init();
    await _storageProvider.initialize(_firebase.firebaseApp);
    await _authProvider.init(_firebase.firebaseApp);
    await _sharedPrefs.init();
  }
}
