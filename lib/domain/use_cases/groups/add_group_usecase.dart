import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/groups_mapper.dart';
import 'package:billsplit_flutter/domain/models/group.dart';

class AddGroupUseCase {
  final _database = getIt<SplitsbyDatabase>();
  final _apiService = getIt<ApiService>();

  Future<Group> launch(Group group) async {
    final response = await _apiService.addGroup(group.toDTO());
    final groupDb = response.toDb();
    await _database.groupsDAO.insertGroup(groupDb);
    return response.toGroup();
  }
}
