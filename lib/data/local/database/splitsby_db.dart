import 'dart:io';

import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;

part 'splitsby_db.g.dart';

@DataClassName("GroupDb")
class Groups extends Table {
  TextColumn get groupId => text().unique()();
  TextColumn get group => text()();
}

@DriftDatabase(tables: [Groups])
class SplitsbyDatabase extends _$SplitsbyDatabase {
  SplitsbyDatabase() : super(_openConnection());

  static SplitsbyDatabase instance = SplitsbyDatabase();

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => destructiveFallback;

  Stream<List<GroupDb>> watchGroups() {
    return select(groups).watch();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
