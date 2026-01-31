import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/local/preferences/models/group_notification_setting.dart';
import 'package:billsplit_flutter/data/local/preferences/shared_prefs.dart';
import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/data/remote/dtos/group_dto.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/groups_mapper.dart';

class GetGroupsUseCase {
  final _apiService = getIt<ApiService>();
  final _database = getIt<SplitsbyDatabase>();
  final _prefs = getIt<SharedPrefs>();

  Future launch() async {
    final response = await _apiService.getGroups();
    final remoteGroups = response.groups;
    final localGroupsDb = await _database.groupsDAO.getGroups();
    await _database.groupsDAO.insertGroups(remoteGroups.toDb());
    await _deleteGroups(localGroupsDb.toDTOs(), remoteGroups);
  }

  /// delete groups that user are no longer apart of
  ///
  /// Clearing the table and reinserting leads to janky behaviour, so we
  /// instead want to only delete those the groups that are missing from
  /// remote
  Future _deleteGroups(
      Iterable<GroupDTO> localGroups, Iterable<GroupDTO> remoteGroups) async {
    final diff = {...localGroups}.difference({...remoteGroups});
    await _database.groupsDAO.deleteGroups(diff.toDb());
  }

  // Store new groups in group notification settings with default value as true
  // we find the difference in ids between remote and local
  // then find the difference between missing ids and unsubs
  // deprecated("Moving towards user-topics only. Kept for reference")
  void _subscribeToGroupTopics(Iterable<String> remoteGroupIds) {
    final localGroupIdSubs =
        _prefs.groupNotificationSettings.map((e) => e.groupId);
    final missingSubscriptions =
        {...remoteGroupIds}.difference({...localGroupIdSubs});
    final newGroupSettings = missingSubscriptions
        .map((groupId) => GroupNotificationSetting.fromNewGroup(groupId));
    _prefs.groupNotificationSettings = [
      ..._prefs.groupNotificationSettings,
      ...newGroupSettings
    ];
  }
}
