import 'package:drift/drift.dart';

@DataClassName("GroupInviteDb")
class GroupInvitesTable extends Table {
  @override
  Set<Column<Object>>? get primaryKey => {groupId};

  TextColumn get groupId => text()();

  IntColumn get syncState => integer()();

  TextColumn get group => text()();
}
