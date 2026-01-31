// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/local/database/daos/group_invites_dao.dart';

// ignore_for_file: type=lint
mixin _$GroupInvitesDAOMixin on DatabaseAccessor<SplitsbyDatabase> {
  $GroupInvitesTableTable get groupInvitesTable =>
      attachedDatabase.groupInvitesTable;
  GroupInvitesDAOManager get managers => GroupInvitesDAOManager(this);
}

class GroupInvitesDAOManager {
  final _$GroupInvitesDAOMixin _db;
  GroupInvitesDAOManager(this._db);
  $$GroupInvitesTableTableTableManager get groupInvitesTable =>
      $$GroupInvitesTableTableTableManager(
        _db.attachedDatabase,
        _db.groupInvitesTable,
      );
}
