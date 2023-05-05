import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/local/preferences/shared_prefs.dart';
import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/groups_mapper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class GetGroupsUseCase {
  final _apiService = getIt<ApiService>();
  final _database = getIt<SplitsbyDatabase>();
  final _prefs = getIt<SharedPrefs>();

  Future launch() async {
    final response = await _apiService.getGroups();
    await _database.groupsDAO.clearTable();
    await _database.groupsDAO.insertGroups(response.groups.toDb());

    // Subscribe to new groups if not unsubscribed
    // we find the difference in ids between remote and local
    // then find the difference between missing ids and unsubs
    final groupIds = response.groups.map((e) => e.id).toSet();
    final missingSubscriptions = groupIds
        .difference(_prefs.groupSubscriptions.toSet())
        .difference(_prefs.groupsUnsubscriptions.toSet());
    for (var groupId in missingSubscriptions) {
      FirebaseMessaging.instance
          .subscribeToTopic("group-$groupId")
          .catchError((e) {
        print("qqq $e");
      });
    }
    _prefs.groupSubscriptions = groupIds.toList();
  }
}
