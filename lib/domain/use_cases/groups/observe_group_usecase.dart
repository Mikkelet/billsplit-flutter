import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/groups_mapper.dart';
import 'package:billsplit_flutter/domain/models/group.dart';

class ObserveGroupUseCase {
  final _database = getIt<SplitsbyDatabase>();

  Stream<Group> invoke(String groupId) async* {
    await for (final groups in _database.groupsDAO.watchGroups()) {
      for (final group in groups) {
        if (group.groupId == groupId) yield group.toGroup();
      }
    }
  }
}
