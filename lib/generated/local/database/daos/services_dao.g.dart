// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/local/database/daos/services_dao.dart';

// ignore_for_file: type=lint
mixin _$ServicesDaoMixin on DatabaseAccessor<SplitsbyDatabase> {
  $ServicesTableTable get servicesTable => attachedDatabase.servicesTable;
  ServicesDaoManager get managers => ServicesDaoManager(this);
}

class ServicesDaoManager {
  final _$ServicesDaoMixin _db;
  ServicesDaoManager(this._db);
  $$ServicesTableTableTableManager get servicesTable =>
      $$ServicesTableTableTableManager(_db.attachedDatabase, _db.servicesTable);
}
