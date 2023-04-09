import 'package:drift/drift.dart';

@DataClassName("GroupDb")
class GroupsTable extends Table {
  TextColumn get groupId => text().unique()();

  TextColumn get group => text()();
}
