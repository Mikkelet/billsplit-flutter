import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/local/database/tables/group_table.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:drift/drift.dart';

part 'groups_dao.g.dart';

@DriftAccessor(tables: [GroupsTable])
class GroupsDAO extends DatabaseAccessor<SplitsbyDatabase>
    with _$GroupsDAOMixin {
  GroupsDAO(super.db);

  Future<void> insertGroups(Iterable<GroupDb> groups) {
    final inserts = groups.map((e) => GroupsTableCompanion(
          group: Value(e.group),
          groupId: Value(e.groupId),
        ));
    return batch(
      (batch) => batch.insertAllOnConflictUpdate(groupsTable, inserts),
    );
  }

  Future<void> insertGroup(GroupDb group) =>
      into(groupsTable).insertOnConflictUpdate(GroupsTableCompanion(
        group: Value(group.group),
        groupId: Value(group.groupId),
      ));

  Future<void> updateLastSynced(String groupId) =>
      (update(groupsTable)..where((tbl) => tbl.groupId.equals(groupId)))
          .write(GroupsTableCompanion(
        groupId: Value(groupId),
        lastUpdated: Value(nowEpoch),
      ));

  Future deleteGroup(GroupDb group) =>
      (delete(groupsTable)..where((tbl) => tbl.groupId.equals(group.groupId)))
          .go();

  Future deleteGroups(Iterable<GroupDb> groups) async {
    for (var group in groups) {
      await deleteGroup(group);
    }
  }

  Future<void> clearTable() => delete(groupsTable).go();

  Future<Iterable<GroupDb>> getGroups() => select(groupsTable).get();

  Future<GroupDb> getGroup(String groupId) =>
      (select(groupsTable)..where((tbl) => tbl.groupId.equals(groupId)))
          .getSingle();

  Stream<Iterable<GroupDb>> watchGroups() {
    return select(groupsTable).watch();
  }
}
