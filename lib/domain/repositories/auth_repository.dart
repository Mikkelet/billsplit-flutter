import 'package:billsplit_flutter/data/auth/auth_provider.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/phone_number.dart';
import 'package:billsplit_flutter/domain/use_cases/profile/parse_phonenumber_usecase.dart';

class AuthRepository {
  final _authProvider = getIt<AuthProvider>();
  final _parsePhoneNumberUseCase = ParsePhoneNumberUseCase();

  Person? _loggedInUser;

  Stream<AuthState> observeAuthState() {
    return _authProvider.authListener().asyncMap((firebaseUser) async {
      if (firebaseUser == null) {
        return LoggedOutState();
      }

      final parsedPhoneNumber =
          await _parsePhoneNumberUseCase.launch(firebaseUser.phoneNumber);
      _loggedInUser = Person(
        firebaseUser.uid,
        firebaseUser.displayName ?? "",
        pfpUrl: firebaseUser.photoURL ?? "",
        email: firebaseUser.email ?? "",
        phoneNumber: parsedPhoneNumber ?? const PhoneNumber.none(),
      );
      return LoggedInState(_loggedInUser!);
    });
  }

  Future updateProfilePicture(String? downloadUrl) {
    return _authProvider.updateProfilePicture(downloadUrl);
  }

  Person get loggedInUser => _loggedInUser!;
}
