import 'package:drift/drift.dart';

@DataClassName("FriendDb")
class FriendsTable extends Table {
  TextColumn get id => text().unique()();

  TextColumn get friend => text()();
}
