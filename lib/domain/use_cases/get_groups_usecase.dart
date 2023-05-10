import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/local/preferences/models/group_notification_setting.dart';
import 'package:billsplit_flutter/data/local/preferences/shared_prefs.dart';
import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/groups_mapper.dart';
import 'package:billsplit_flutter/presentation/features/group/notifications_settings/notification_topics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class GetGroupsUseCase {
  final _apiService = getIt<ApiService>();
  final _database = getIt<SplitsbyDatabase>();
  final _prefs = getIt<SharedPrefs>();

  Future launch() async {
    final response = await _apiService.getGroups();
    await _database.groupsDAO.clearTable();
    await _database.groupsDAO.insertGroups(response.groups.toDb());
    subscribeToGroupTopics(response.groups.map((e) => e.id).toSet());
  }

  // Store new groups in group notification settings with default value as true
  // we find the difference in ids between remote and local
  // then find the difference between missing ids and unsubs
  void subscribeToGroupTopics(Set<String> remoteGroupIds) {
    final localGroupIdSubs =
        _prefs.groupNotificationSettings.map((e) => e.groupId);
    final missingSubscriptions =
        remoteGroupIds.difference(localGroupIdSubs.toSet());

    final List<Future> subFutures = [];
    for (var topic in NotificationTopic.values) {
      for (var groupId in missingSubscriptions) {
        final futureSub = FirebaseMessaging.instance
            .subscribeToTopic(topic.getTopicId(groupId))
            .then((value) {
        }).catchError((e) {
          print("qqq $e");
        });
        subFutures.add(futureSub);
      }
    }
    Future.forEach(subFutures, (element) {}).whenComplete(() {
      final newGroupSettings = missingSubscriptions
          .map((groupId) => GroupNotificationSetting.fromNewGroup(groupId));
      print("qqq newGroups=${newGroupSettings.length}");
      print("qqq totalGroup=${[..._prefs.groupNotificationSettings, ...newGroupSettings]}");
      _prefs.groupNotificationSettings = [
        ..._prefs.groupNotificationSettings,
        ...newGroupSettings
      ];
    });
  }
}
