// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/local/database/daos/friends_dao.dart';

// ignore_for_file: type=lint
mixin _$FriendsDAOMixin on DatabaseAccessor<SplitsbyDatabase> {
  $FriendsTableTable get friendsTable => attachedDatabase.friendsTable;
  FriendsDAOManager get managers => FriendsDAOManager(this);
}

class FriendsDAOManager {
  final _$FriendsDAOMixin _db;
  FriendsDAOManager(this._db);
  $$FriendsTableTableTableManager get friendsTable =>
      $$FriendsTableTableTableManager(_db.attachedDatabase, _db.friendsTable);
}
