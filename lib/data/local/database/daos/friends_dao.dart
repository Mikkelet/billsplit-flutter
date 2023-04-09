import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/local/database/tables/friend_table.dart';
import 'package:drift/drift.dart';

part 'friends_dao.g.dart';

@DriftAccessor(tables: [FriendsTable])
class FriendsDAO extends DatabaseAccessor<SplitsbyDatabase>
    with _$FriendsDAOMixin {
  FriendsDAO(SplitsbyDatabase db) : super(db);

  Future insert(FriendDb expense) => into(friendsTable).insert(expense);

  Future insertAll(List<FriendDb> expenses) =>
      batch((batch) => batch.insertAll(friendsTable, expenses));

  Stream<List<FriendDb>> watch(String groupId) {
    return select(friendsTable).watch();
  }

  Future clearTable() => delete(friendsTable).go();
}
