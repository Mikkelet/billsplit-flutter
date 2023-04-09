import 'package:drift/drift.dart';

@DataClassName("GroupExpenseDb")
class GroupExpenseTable extends Table {
  TextColumn get id => text().unique()();

  TextColumn get groupId => text()();

  TextColumn get groupExpense => text()();
}
