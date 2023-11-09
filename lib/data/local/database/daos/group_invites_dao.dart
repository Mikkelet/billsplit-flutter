import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/local/database/tables/group_invites_table.dart';
import 'package:billsplit_flutter/domain/models/sync_state.dart';
import 'package:drift/drift.dart';

part '../../../../generated/local/database/daos/group_invites_dao.g.dart';

@DriftAccessor(tables: [GroupInvitesTable])
class GroupInvitesDAO extends DatabaseAccessor<SplitsbyDatabase>
    with _$GroupInvitesDAOMixin {
  GroupInvitesDAO(super.db);

  Future<void> insertGroups(Iterable<GroupInviteDb> groupInvites) {
    final inserts = groupInvites.map(
      (e) => GroupInvitesTableCompanion.insert(
        groupId: e.groupId,
        syncState: e.syncState,
        group: e.group,
      ),
    );
    return batch(
      (batch) => batch.insertAllOnConflictUpdate(groupInvitesTable, inserts),
    );
  }

  Future<void> insert(GroupInviteDb groupInviteDb) async {
    await groupInvitesTable.insertOnConflictUpdate(groupInviteDb);
  }

  Stream<Iterable<GroupInviteDb>> watchGroups() {
    return select(groupInvitesTable).watch();
  }

  Future clear() async {
    await groupInvitesTable.deleteAll();
  }

  Future remove(GroupDb groupInvite) async {
    await (delete(groupInvitesTable)
          ..where((tbl) => tbl.groupId.equals(groupInvite.groupId)))
        .go();
  }

  Future updatePending(GroupDb group) async {
    await (update(groupInvitesTable)
          ..where((tbl) => tbl.groupId.equals(group.groupId)))
        .write(GroupInvitesTableCompanion(
      groupId: Value(group.groupId),
      syncState: Value(SyncState.pending.index),
    ));
  }
}
