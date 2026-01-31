// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/local/database/daos/payments_dao.dart';

// ignore_for_file: type=lint
mixin _$PaymentsDAOMixin on DatabaseAccessor<SplitsbyDatabase> {
  $PaymentsTableTable get paymentsTable => attachedDatabase.paymentsTable;
  PaymentsDAOManager get managers => PaymentsDAOManager(this);
}

class PaymentsDAOManager {
  final _$PaymentsDAOMixin _db;
  PaymentsDAOManager(this._db);
  $$PaymentsTableTableTableManager get paymentsTable =>
      $$PaymentsTableTableTableManager(_db.attachedDatabase, _db.paymentsTable);
}
