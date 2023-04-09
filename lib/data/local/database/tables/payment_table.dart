import 'package:drift/drift.dart';

@DataClassName("PaymentDb")
class PaymentsTable extends Table {
  TextColumn get id => text().unique()();

  TextColumn get groupId => text()();

  TextColumn get payment => text()();
}
