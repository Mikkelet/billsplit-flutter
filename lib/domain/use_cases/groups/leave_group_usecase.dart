import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/groups_mapper.dart';

class LeaveGroupUseCase {
  final _apiService = getIt<ApiService>();
  final _database = getIt<SplitsbyDatabase>();

  Future launch(String groupId) async {
    final groupDto = await _apiService.leaveGroup(groupId);
    await _database.groupsDAO.deleteGroup(groupDto.toDb());
  }
}