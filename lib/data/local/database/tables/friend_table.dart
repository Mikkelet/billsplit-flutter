import 'package:drift/drift.dart';

@DataClassName("FriendDb")
class FriendsTable extends Table {
  TextColumn get uid => text().unique()();

  TextColumn get status => text()();

  TextColumn get createdBy => text()();

  TextColumn get friend => text()();
}
