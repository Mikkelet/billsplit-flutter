import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/local/database/tables/friend_table.dart';
import 'package:drift/drift.dart';

part 'friends_dao.g.dart';

@DriftAccessor(tables: [FriendsTable])
class FriendsDAO extends DatabaseAccessor<SplitsbyDatabase>
    with _$FriendsDAOMixin {
  FriendsDAO(SplitsbyDatabase db) : super(db);

  Future insert(FriendDb expense) =>
      into(friendsTable).insert(expense, mode: InsertMode.insertOrReplace);

  Future insertAll(Iterable<FriendDb> expenses) => batch((batch) => batch
      .insertAll(friendsTable, expenses, mode: InsertMode.insertOrReplace));

  Stream<Iterable<FriendDb>> watch() {
    return select(friendsTable).watch();
  }

  Future clearTable() => delete(friendsTable).go();
}
