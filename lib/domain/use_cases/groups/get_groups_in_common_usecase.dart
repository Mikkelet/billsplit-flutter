import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/groups_mapper.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';

class GetGroupsInCommonUseCase {
  final _database = getIt<SplitsbyDatabase>();

  Future<Iterable<Group>> launch(Person person) async {
    final allGroups = await _database.groupsDAO.getGroups();
    final groupsInCommon = allGroups
        .map((e) => e.toGroup())
        .where((group) => group.people.contains(person));
    return groupsInCommon;
  }
}
