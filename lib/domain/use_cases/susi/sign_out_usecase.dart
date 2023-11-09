import 'package:billsplit_flutter/data/auth/auth_provider.dart';
import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/local/preferences/shared_prefs.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/repositories/auth_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SignOutUseCase {
  final _authProvider = getIt<AuthProvider>();
  final _authRepository = getIt<AuthRepository>();
  final _database = getIt<SplitsbyDatabase>();
  final _sharedPrefs = getIt<SharedPrefs>();

  Future launch() async {
    _sharedPrefs.isUserLoggedIn = false;
    await FirebaseMessaging.instance.unsubscribeFromTopic("user-${_authRepository.loggedInUser.uid}");
    await _database.friendsDAO.clearTable();
    await _database.groupsDAO.clearTable();
    await _database.groupExpenseDAO.clearTable();
    await _database.paymentsDAO.clearTable();
    await _database.servicesDao.clearTable();
    await _authProvider.signOut();
  }
}
