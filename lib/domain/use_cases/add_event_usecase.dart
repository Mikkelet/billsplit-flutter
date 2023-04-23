import 'package:billsplit_flutter/data/debt_calculator.dart';
import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/data/remote/dtos/debts_dto.dart';
import 'package:billsplit_flutter/data/remote/dtos/event_dto.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/event_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/group_expense_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/groups_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/payment_mapper.dart';
import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/utils/pair.dart';

class AddEventUseCase {
  final _apiService = getIt<ApiService>();
  final _database = getIt<SplitsbyDatabase>();

  AddEventUseCase();

  Future launch(String groupId, Event event) async {
    final debtForGroup = (await _getDebtWithAddedEvent(groupId, event))
        .map((e) => DebtDTO(e.first, e.second))
        .toList();

    final response =
        await _apiService.addEvent(groupId, event.toEventDTO(), debtForGroup);

    final EventDTO eventDto = response.event!;

    if (eventDto is GroupExpenseDTO) {
      final expenseDb = eventDto.toDb(groupId);
      await _database.groupExpenseDAO.insert(expenseDb);
    } else if (eventDto is PaymentDTO) {
      final paymentDb = eventDto.toDb(groupId);
      await _database.paymentsDAO.insert(paymentDb);
    }

    // update group
    final groupResponse = await _apiService.getGroup(groupId);
    await _database.groupsDAO.insertGroup(groupResponse.group.toDb());
  }

  Future<Iterable<Pair<String, num>>> _getDebtWithAddedEvent(
      String groupId, Event event) async {
    final groupDb = (await _database.groupsDAO.getGroup(groupId)).toGroup();
    final people = groupDb.people.toList();
    final groupExpenses = (await _database.groupExpenseDAO.watch(groupId).first)
        .toGroupExpenses();
    List<GroupExpense> groupExpensesWithEvent = groupExpenses.toList();
    if (event is GroupExpense) {
      groupExpensesWithEvent = [...groupExpenses, event];
    }
    final payments = (await _database.paymentsDAO.watch(groupId).first)
        .toPayments()
        .toList();
    final debt = DebtCalculator(people, groupExpensesWithEvent, payments)
        .calculateEffectiveDebtForGroup();
    return debt;
  }
}
