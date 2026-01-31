// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/local/database/daos/groups_dao.dart';

// ignore_for_file: type=lint
mixin _$GroupsDAOMixin on DatabaseAccessor<SplitsbyDatabase> {
  $GroupsTableTable get groupsTable => attachedDatabase.groupsTable;
  GroupsDAOManager get managers => GroupsDAOManager(this);
}

class GroupsDAOManager {
  final _$GroupsDAOMixin _db;
  GroupsDAOManager(this._db);
  $$GroupsTableTableTableManager get groupsTable =>
      $$GroupsTableTableTableManager(_db.attachedDatabase, _db.groupsTable);
}
