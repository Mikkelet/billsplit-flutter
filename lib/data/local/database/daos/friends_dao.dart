import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/local/database/tables/friend_table.dart';
import 'package:drift/drift.dart';

part '../../../../generated/local/database/daos/friends_dao.g.dart';

@DriftAccessor(tables: [FriendsTable])
class FriendsDAO extends DatabaseAccessor<SplitsbyDatabase>
    with _$FriendsDAOMixin {
  FriendsDAO(super.db);

  Future insert(FriendDb friend) =>
      into(friendsTable).insert(friend, mode: InsertMode.insertOrReplace);

  Future insertAll(Iterable<FriendDb> friend) => batch((batch) =>
      batch.insertAll(friendsTable, friend, mode: InsertMode.insertOrReplace));

  Future deleteFriend(FriendDb friendDb) => friendsTable.deleteOne(friendDb);

  Future<FriendDb?> getFriend(String uid) async {
    return (select(friendsTable)..where((tbl) => tbl.uid.equals(uid)))
        .getSingleOrNull();
  }

  Stream<Iterable<FriendDb>> watch() {
    return select(friendsTable).watch();
  }

  Future clearTable() => delete(friendsTable).go();
}
