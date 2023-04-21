import 'package:billsplit_flutter/data/auth/auth_provider.dart';
import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/di/get_it.dart';

class SignOutUseCase {
  final _authProvider = getIt<AuthProvider>();
  final _database = getIt<SplitsbyDatabase>();

  Future launch() async {
    await _database.friendsDAO.clearTable();
    await _database.groupsDAO.clearTable();
    await _database.groupExpenseDAO.clearTable();
    await _database.paymentsDAO.clearTable();
    await _database.servicesDao.clearTable();
    await _authProvider.signOut();
  }
}