import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/local/database/tables/group_invites_table.dart';
import 'package:drift/drift.dart';

part 'group_invites_dao.g.dart';

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
}
