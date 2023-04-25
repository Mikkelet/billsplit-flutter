import 'package:drift/drift.dart';

@DataClassName("GroupDb")
class GroupsTable extends Table {
  @override
  Set<Column<Object>>? get primaryKey => {groupId, group};

  TextColumn get groupId => text().unique()();

  TextColumn get group => text()();
}
