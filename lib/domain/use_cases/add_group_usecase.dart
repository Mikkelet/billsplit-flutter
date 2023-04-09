import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/domain/mappers/groups_mapper.dart';
import 'package:billsplit_flutter/domain/models/group.dart';

class AddGroupUseCase {
  final _database = SplitsbyDatabase.instance;

  Future launch(Group group) async {
    final groupDb = group.toDb();
    await _database.groupsDAO.insertGroup(groupDb);
  }
}
