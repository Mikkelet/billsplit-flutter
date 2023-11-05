import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/groups_mapper.dart';
import 'package:billsplit_flutter/domain/use_cases/events/get_events_usecase.dart';

class GetGroupUseCase {
  final _apiService = getIt<ApiService>();
  final _database = getIt<SplitsbyDatabase>();
  final _getEventsUseCase = GetEventsUseCase();

  Future<void> launch(String groupId) async {
    final response = await _apiService.getGroup(groupId);
    await _database.groupsDAO.insertGroup(response.group.toDb());
    final shouldSync = await _shouldSync(groupId);
    if (!shouldSync) return;
    await _getEventsUseCase.launch(groupId);
  }

  Future<bool> _shouldSync(String groupId) async {
    final groupDb = await _database.groupsDAO.getGroup(groupId);
    final group = groupDb.toGroup();
    final lastSynced = groupDb.lastUpdated;
    final lastUpdated = group.lastUpdatedState;
    if (lastSynced == null) return true;
    return lastUpdated > lastSynced;
  }
}
