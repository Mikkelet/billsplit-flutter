import 'package:drift/drift.dart';

@DataClassName("GroupDb")
class GroupsTable extends Table {

  TextColumn get groupId => text().unique()();

  IntColumn get lastUpdated => integer().nullable()();

  TextColumn get group => text()();
}
