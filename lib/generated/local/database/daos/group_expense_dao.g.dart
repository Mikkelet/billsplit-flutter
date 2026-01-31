// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/local/database/daos/group_expense_dao.dart';

// ignore_for_file: type=lint
mixin _$GroupExpenseDAOMixin on DatabaseAccessor<SplitsbyDatabase> {
  $GroupExpenseTableTable get groupExpenseTable =>
      attachedDatabase.groupExpenseTable;
  GroupExpenseDAOManager get managers => GroupExpenseDAOManager(this);
}

class GroupExpenseDAOManager {
  final _$GroupExpenseDAOMixin _db;
  GroupExpenseDAOManager(this._db);
  $$GroupExpenseTableTableTableManager get groupExpenseTable =>
      $$GroupExpenseTableTableTableManager(
        _db.attachedDatabase,
        _db.groupExpenseTable,
      );
}
