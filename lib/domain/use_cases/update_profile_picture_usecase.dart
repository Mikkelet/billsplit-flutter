import 'package:billsplit_flutter/data/auth/auth_provider.dart';
import 'package:billsplit_flutter/data/remote/storage/storage_provider.dart';
import 'package:billsplit_flutter/di/get_it.dart';

class UpdateProfilePictureUseCase {
  final _authProvider = getIt<AuthProvider>();
  final _storageProvider = getIt<FirebaseStorageProvider>();

  Future<String> launch(Uri uri) async {
    final downloadUrl = await _storageProvider.uploadProfilePicture(_authProvider.user!.uid, uri);
    _authProvider.updateProfilePicture(downloadUrl);
    return downloadUrl;
  }
}
