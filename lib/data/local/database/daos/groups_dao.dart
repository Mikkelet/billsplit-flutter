import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/local/database/tables/group_db.dart';
import 'package:drift/drift.dart';

part 'groups_dao.g.dart';

@DriftAccessor(tables: [GroupsTable])
class GroupsDAO extends DatabaseAccessor<SplitsbyDatabase>
    with _$GroupsDAOMixin {
  GroupsDAO(SplitsbyDatabase db) : super(db);

  Future<void> insertGroups(List<GroupDb> groups) =>
      batch((batch) => batch.insertAll(groupsTable, groups));

  Future<void> insertGroup(GroupDb group) => into(groupsTable).insert(group);

  Future<void> clearTable() => delete(groupsTable).go();

  Future<List<GroupDb>> getGroups() => select(groupsTable).get();

  Stream<List<GroupDb>> watchGroups() {
    return select(groupsTable).watch();
  }
}
