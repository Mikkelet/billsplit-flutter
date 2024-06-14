import 'package:billsplit_flutter/data/auth/auth_provider.dart';
import 'package:billsplit_flutter/data/remote/storage/storage_provider.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/repositories/auth_repository.dart';

class UpdateProfilePictureUseCase {
  final _authProvider = getIt<AuthProvider>();
  final _authRepository = getIt<AuthRepository>();
  final _storageProvider = getIt<FirebaseStorageProvider>();

  Future launch(Uri uri) async {
    final downloadUrl = await _storageProvider.uploadProfilePicture(
        _authRepository.loggedInUser.uid, uri);
    _authProvider.updateProfilePicture(downloadUrl);
    _authRepository.loggedInUser.pfpUrlState.value = downloadUrl;
  }
}
