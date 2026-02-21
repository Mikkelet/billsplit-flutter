import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/group_expense_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/payment_mapper.dart';
import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/payment_event.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:rxdart/rxdart.dart';

class ObserveGroupExpenseUseCase {
  final _database = getIt<SplitsbyDatabase>();

  Stream<GroupExpense> observe(String groupId, String eventId) async* {
    await for (final events in _database.groupExpenseDAO.watch(groupId)) {
      for (final event in events) {
        if (event.id == eventId) yield event.toGroupExpense();
      }
    }
  }
}
