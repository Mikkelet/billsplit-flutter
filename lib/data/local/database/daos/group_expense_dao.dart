import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/local/database/tables/group_expense_db.dart';
import 'package:drift/drift.dart';

part 'group_expense_dao.g.dart';

@DriftAccessor(tables: [GroupExpenseTable])
class GroupExpenseDAO extends DatabaseAccessor<SplitsbyDatabase>
    with _$GroupExpenseDAOMixin {
  GroupExpenseDAO(SplitsbyDatabase db) : super(db);

  Future insert(GroupExpenseDb expense) =>
      into(groupExpenseTable).insert(expense, mode: InsertMode.insertOrReplace);

  Future insertAll(List<GroupExpenseDb> expenses) =>
      batch((batch) => batch.insertAll(groupExpenseTable, expenses,
          mode: InsertMode.insertOrReplace));

  Stream<List<GroupExpenseDb>> watch(String groupId) {
    return (select(groupExpenseTable)
          ..where((tbl) => tbl.groupId.equals(groupId)))
        .watch();
  }

  Future clearTable() => delete(groupExpenseTable).go();

  Future clearForGroup(String groupId) =>
      (delete(groupExpenseTable)..where((tbl) => tbl.groupId.equals(groupId)))
          .go();
}
