import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/use_cases/events/get_events_usecase.dart';

class GetGroupUseCase {
  final _apiService = getIt<ApiService>();
  final _database = getIt<SplitsbyDatabase>();
  final _getEventsUseCase = GetEventsUseCase();

  Future<void> launch(String groupId) async {
    final response = await _apiService.getGroup(groupId);
    final shouldSync = await _shouldSync(groupId, response.group.lastUpdated);
    if (!shouldSync) return;
    await _getEventsUseCase.launch(groupId);
  }

  Future<bool> _shouldSync(String groupId, int remoteLastSync) async {
    final localGroup = await _database.groupsDAO.getGroup(groupId);
    final localLastSync = localGroup.lastUpdated;
    if (localLastSync == null) return true;
    return remoteLastSync > localLastSync;
  }
}
