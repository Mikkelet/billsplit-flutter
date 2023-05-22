import 'package:billsplit_flutter/data/auth/auth_provider.dart';
import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/local/preferences/shared_prefs.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/presentation/features/group/notifications_settings/notification_topics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SignOutUseCase {
  final _authProvider = getIt<AuthProvider>();
  final _database = getIt<SplitsbyDatabase>();
  final _sharedPrefs = getIt<SharedPrefs>();

  Future launch() async {
    FirebaseMessaging.instance.unsubscribeFromTopic("user-${_authProvider.user?.uid}");
    await _database.friendsDAO.clearTable();
    await _database.groupsDAO.clearTable();
    await _database.groupExpenseDAO.clearTable();
    await _database.paymentsDAO.clearTable();
    await _database.servicesDao.clearTable();
    await _authProvider.signOut();
    unsubscribeFromGroups();
  }

  Future unsubscribeFromGroups() async {
    final groupIds =
        _sharedPrefs.groupNotificationSettings.map((e) => e.groupId);
    final List<Future> futures = [];
    for (var groupId in groupIds) {
      for (var notificationTopic in NotificationTopic.values) {
        final topicId = notificationTopic.getTopicId(groupId);
        futures.add(FirebaseMessaging.instance.unsubscribeFromTopic(topicId));
      }
    }
    Future.wait(futures).whenComplete(() {
      _sharedPrefs.groupNotificationSettings = [];
    });
  }
}
