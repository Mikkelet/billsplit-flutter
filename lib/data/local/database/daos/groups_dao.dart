import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/local/database/tables/group_db.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:drift/drift.dart';

part 'groups_dao.g.dart';

@DriftAccessor(tables: [GroupsTable])
class GroupsDAO extends DatabaseAccessor<SplitsbyDatabase>
    with _$GroupsDAOMixin {
  GroupsDAO(super.db);

  Future<void> insertGroups(List<GroupDb> groups) {
    final inserts = groups.map((e) =>
        GroupsTableCompanion(group: Value(e.group), groupId: Value(e.groupId)));
    return batch((batch) => batch.insertAll(groupsTable, inserts,
        mode: InsertMode.insertOrReplace));
  }

  Future<void> insertGroup(GroupDb group) =>
      (update(groupsTable)..where((tbl) => tbl.groupId.equals(group.groupId)))
          .write(GroupsTableCompanion(group: Value(group.group)));

  Future<void> updateLastSynced(String groupId) =>
      (update(groupsTable)..where((tbl) => tbl.groupId.equals(groupId))).write(
        GroupsTableCompanion(
          lastUpdated: Value(nowEpoch),
        ),
      );

  Future deleteGroup(GroupDb group) =>
      (delete(groupsTable)..where((tbl) => tbl.groupId.equals(group.groupId)))
          .go();

  Future<void> clearTable() => delete(groupsTable).go();

  Future<List<GroupDb>> getGroups() => select(groupsTable).get();

  Future<GroupDb> getGroup(String groupId) =>
      (select(groupsTable)..where((tbl) => tbl.groupId.equals(groupId)))
          .getSingle();

  Stream<List<GroupDb>> watchGroups() {
    return select(groupsTable).watch();
  }
}
