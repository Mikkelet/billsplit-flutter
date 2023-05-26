import 'package:billsplit_flutter/data/auth/auth_provider.dart';
import 'package:billsplit_flutter/data/remote/storage/storage_provider.dart';
import 'package:billsplit_flutter/di/get_it.dart';

class DeleteProfilePictureUseCase {
  final _authProvider = getIt<AuthProvider>();
  final _storageProvider = getIt<FirebaseStorageProvider>();

  Future launch() async {
    if (_authProvider.user != null) {
      await _storageProvider.deleteProfilePicture(_authProvider.user!.uid);
    }
    await _authProvider.updateProfilePicture(null);
  }
}
