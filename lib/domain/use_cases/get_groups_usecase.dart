import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/domain/mappers/groups_mapper.dart';
import 'package:billsplit_flutter/domain/models/group.dart';

class GetGroupsUseCase {
  final _apiService = ApiService();
  final _database = SplitsbyDatabase.instance;

  Future<List<Group>> launch() async {
    final response = await _apiService.getGroups();
    await _database.groupsDAO.clearTable();
    await _database.groupsDAO.insertGroups(response.groups.toDb());
    return response.groups.toGroups();
  }
}
