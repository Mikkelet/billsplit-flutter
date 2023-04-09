import 'package:drift/drift.dart';

@DataClassName("ServiceDb")
class ServicesTable extends Table {
  TextColumn get id => text().unique()();

  TextColumn get groupId => text()();

  TextColumn get service => text()();
}
