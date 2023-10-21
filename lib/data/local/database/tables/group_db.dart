import 'package:drift/drift.dart';

@DataClassName("GroupDb")
class GroupsTable extends Table {
  @override
  Set<Column<Object>>? get primaryKey => {groupId};

  TextColumn get groupId => text()();

  IntColumn get lastUpdated => integer().nullable()();

  TextColumn get group => text()();
}
