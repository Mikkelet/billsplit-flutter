import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/groups_mapper.dart';
import 'package:billsplit_flutter/domain/models/group.dart';

class GetLocalGroupUseCase {
  final _database = getIt<SplitsbyDatabase>();

  Future<Group> launch(String groupId) async {
    final db = await _database.groupsDAO.getGroup(groupId);
    return db.toGroup();
  }
}
