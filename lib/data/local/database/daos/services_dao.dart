import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/local/database/tables/services_table.dart';
import 'package:drift/drift.dart';

part 'services_dao.g.dart';

@DriftAccessor(tables: [ServicesTable])
class ServicesDao extends DatabaseAccessor<SplitsbyDatabase>
    with _$ServicesDaoMixin {
  ServicesDao(SplitsbyDatabase db) : super(db);

  Future insert(ServiceDb service) => into(servicesTable).insert(service);

  Future insertAll(List<ServiceDb> expenses) =>
      batch((batch) => batch.insertAll(servicesTable, expenses));

  Stream<List<ServiceDb>> watch(String groupId) {
    return (select(servicesTable)..where((tbl) => tbl.groupId.equals(groupId)))
        .watch();
  }

  Future clearTable() => delete(servicesTable).go();

  Future clearForGroup(String groupId) =>
      (delete(servicesTable)..where((tbl) => tbl.groupId.equals(groupId))).go();
}
