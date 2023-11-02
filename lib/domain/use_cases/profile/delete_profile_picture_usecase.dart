import 'package:billsplit_flutter/data/auth/auth_provider.dart';
import 'package:billsplit_flutter/data/remote/storage/storage_provider.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/repositories/auth_repository.dart';

class DeleteProfilePictureUseCase {
  final _authRepository = getIt<AuthRepository>();
  final _authProvider = getIt<AuthProvider>();
  final _storageProvider = getIt<FirebaseStorageProvider>();

  Future launch() async {
    if (_authRepository.loggedInUser.pfpUrlState.isNotEmpty) {
      await _storageProvider
          .deleteProfilePicture(_authRepository.loggedInUser.uid);
    }
    await _authProvider.updateProfilePicture(null);
  }
}
