import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/domain/mappers/groups_mapper.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:drift/drift.dart';

class GetGroupsUseCase {
  final _apiService = ApiService();
  final _database = SplitsbyDatabase.instance;

  Future<List<Group>> launch() async {
    final response = await _apiService.getGroups();
    await _database.batch(
        (batch) => batch.insertAll(_database.groups, response.groups.toDb(), mode: InsertMode.insertOrReplace));
    return response.groups.toGroups();
  }
}
