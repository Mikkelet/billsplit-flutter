import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/groups_mapper.dart';

class SyncGroupInvitesUseCase {
  final _apiService = getIt<ApiService>();
  final _database = getIt<SplitsbyDatabase>();

  Future launch() async {
    final response = await _apiService.getGroupInvites();
    final groups = response.groups;
    final groupInvitesDb = groups.toGroupInviteDb();
    await _database.groupInvitesDAO.clear();
    await _database.groupInvitesDAO.insertGroups(groupInvitesDb);
  }
}