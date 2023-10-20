import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/local/database/tables/payment_table.dart';
import 'package:drift/drift.dart';

part 'payments_dao.g.dart';

@DriftAccessor(tables: [PaymentsTable])
class PaymentsDAO extends DatabaseAccessor<SplitsbyDatabase>
    with _$PaymentsDAOMixin {
  PaymentsDAO(SplitsbyDatabase db) : super(db);

  Future insert(PaymentDb payment) =>
      into(paymentsTable).insert(payment, mode: InsertMode.insertOrReplace);

  Future insertAll(Iterable<PaymentDb> expenses) => batch((batch) => batch
      .insertAll(paymentsTable, expenses, mode: InsertMode.insertOrReplace));

  Future<PaymentDb> get(String id) {
    return (select(paymentsTable)..where((tbl) => tbl.groupId.equals(id))).getSingle();
  }

  Stream<Iterable<PaymentDb>> watch(String groupId) {
    return (select(paymentsTable)..where((tbl) => tbl.groupId.equals(groupId)))
        .watch();
  }

  Future clearTable() => delete(paymentsTable).go();

  Future clearForGroup(String groupId) =>
      (delete(paymentsTable)..where((tbl) => tbl.groupId.equals(groupId))).go();
}
