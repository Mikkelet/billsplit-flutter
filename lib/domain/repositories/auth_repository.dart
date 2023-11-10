import 'dart:developer';

import 'package:billsplit_flutter/data/auth/auth_provider.dart';
import 'package:billsplit_flutter/data/local/preferences/shared_prefs.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/phone_number.dart';
import 'package:billsplit_flutter/domain/repositories/auth_state.dart';
import 'package:billsplit_flutter/domain/use_cases/profile/parse_phonenumber_usecase.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthRepository {
  final _authProvider = getIt<AuthProvider>();
  final _parsePhoneNumberUseCase = ParsePhoneNumberUseCase();
  final _sharedPrefs = getIt<SharedPrefs>();

  Person? _loggedInUser;

  Stream<AuthState> observeAuthState() {
    return _authProvider.authListener().asyncMap((firebaseUser) async {
      if (firebaseUser == null) {
        if (_sharedPrefs.isUserLoggedIn) {
          _sharedPrefs.isUserLoggedIn = true;
          return LoggedInState(Person.dummy(123));
        }
        return LoggedOutState();
      }

      _sharedPrefs.isUserLoggedIn = true;

      final parsedPhoneNumber =
          await _parsePhoneNumberUseCase.launch(firebaseUser.phoneNumber);
      _loggedInUser = Person(
        firebaseUser.uid,
        firebaseUser.displayName ?? "",
        pfpUrl: firebaseUser.photoURL ?? "",
        email: firebaseUser.email ?? "",
        phoneNumber: parsedPhoneNumber ?? const PhoneNumber.none(),
      );
      _subscribeToUserTopic(_loggedInUser!);
      return LoggedInState(_loggedInUser!);
    }).map((event) {
      if (event is LoggedOutState) {
        _loggedInUser = null;
      }
      return event;
    });
  }

  void _subscribeToUserTopic(Person person) async {
    final topic = "user-${person.uid}";
    try {
      await FirebaseMessaging.instance.subscribeToTopic(topic);
    } catch (e, st) {
      log("error subscribing to topic=$topic", stackTrace: st, error: e);
    }
  }

  Future updateProfilePicture(String? downloadUrl) {
    return _authProvider.updateProfilePicture(downloadUrl);
  }

  Person get loggedInUser => _loggedInUser!;
}
