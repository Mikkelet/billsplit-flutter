import 'dart:io';

import 'package:billsplit_flutter/data/local/database/daos/friends_dao.dart';
import 'package:billsplit_flutter/data/local/database/daos/group_expense_dao.dart';
import 'package:billsplit_flutter/data/local/database/daos/groups_dao.dart';
import 'package:billsplit_flutter/data/local/database/daos/payments_dao.dart';
import 'package:billsplit_flutter/data/local/database/daos/services_dao.dart';
import 'package:billsplit_flutter/data/local/database/tables/friend_table.dart';
import 'package:billsplit_flutter/data/local/database/tables/group_table.dart';
import 'package:billsplit_flutter/data/local/database/tables/group_expense_db.dart';
import 'package:billsplit_flutter/data/local/database/tables/payment_table.dart';
import 'package:billsplit_flutter/data/local/database/tables/services_table.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;

part 'splitsby_db.g.dart';

@DriftDatabase(
    tables: [GroupsTable, GroupExpenseTable, FriendsTable, ServicesTable, PaymentsTable],
    daos: [GroupsDAO, GroupExpenseDAO, ServicesDao, FriendsDAO, PaymentsDAO])
class SplitsbyDatabase extends _$SplitsbyDatabase {
  SplitsbyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 9;

  @override
  MigrationStrategy get migration => destructiveFallback;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
