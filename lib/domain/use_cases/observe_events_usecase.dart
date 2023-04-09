import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/domain/mappers/group_expense_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/payment_mapper.dart';
import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:rxdart/rxdart.dart';

class ObserveEventsUseCase {
  final _database = SplitsbyDatabase.instance;

  Stream<Iterable<Event>> observe(String groupId) {
    final Stream<Iterable<Payment>> paymentsStream =
        _database.paymentsDAO.watch(groupId).map((event) => event.toPayments());
    final Stream<Iterable<GroupExpense>> expensesStream = _database
        .groupExpenseDAO
        .watch(groupId)
        .map((event) => event.toGroupExpenses());

    return CombineLatestStream(
        [paymentsStream, expensesStream], (values) => values.flatMap());
  }
}
