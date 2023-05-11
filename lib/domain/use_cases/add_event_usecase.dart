import 'package:billsplit_flutter/data/debt_calculator.dart';
import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/data/remote/dtos/debts_dto.dart';
import 'package:billsplit_flutter/data/remote/dtos/event_dto.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/debts_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/event_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/group_expense_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/groups_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/payment_mapper.dart';
import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/payment_event.dart';
import 'package:billsplit_flutter/domain/models/sync_state.dart';
import 'package:billsplit_flutter/utils/constants.dart';
import 'package:billsplit_flutter/utils/pair.dart';

class AddEventUseCase {
  final _apiService = getIt<ApiService>();
  final _database = getIt<SplitsbyDatabase>();
  bool shouldFail = true;

  Future launch(String groupId, Event event) async {
    // store pending event in db, will be updated later
    String tempId = event.id.isEmpty ? "$tempIdPrefix-${event.hashCode}" : event.id;
    if (event is GroupExpense) {
      final expenseDb = event.toDb(groupId, SyncState.pending, tempId: tempId);
      await _database.groupExpenseDAO.insert(expenseDb);
      await Future.delayed(const Duration(seconds: 2));
    }

    try {
      if(shouldFail){
        shouldFail = false;
        throw Exception("error!");
      }
      final debtForGroup = (await _getDebtWithAddedEvent(groupId, event))
          .map((e) => DebtDTO(e.first, e.second))
          .toList();

      final response =
          await _apiService.addEvent(groupId, event.toEventDTO(), debtForGroup);

      final EventDTO eventDto = response.event!;

      if (eventDto is GroupExpenseDTO) {
        final expenseDb = eventDto.toDb(groupId, SyncState.synced);
        await _database.groupExpenseDAO.deleteExpense(tempId);
        await _database.groupExpenseDAO.insert(expenseDb);
      } else if (eventDto is PaymentDTO) {
        final paymentDb = eventDto.toDb(groupId);
        await _database.paymentsDAO.insert(paymentDb);
      }

      // update group
      final groupResponse = await _database.groupsDAO.getGroup(groupId);
      final group = groupResponse.toGroup();
      group.debtState = debtForGroup.toDebts();
      if (eventDto.toEvent() != null) {
        group.latestEventState = eventDto.toEvent();
      }
      await _database.groupsDAO.insertGroup(group.toDb());
    } catch (e) {
      if (event is GroupExpense) {
        final expenseDb = event.toDb(groupId, SyncState.failed, tempId: tempId);
        await _database.groupExpenseDAO.insert(expenseDb);
      }
      rethrow;
    }
  }

  Future<Iterable<Pair<String, num>>> _getDebtWithAddedEvent(
      String groupId, Event event) async {
    final groupDb = await _database.groupsDAO.getGroup(groupId);
    final group = groupDb.toGroup();
    final people = group.allPeople.toList();
    final groupExpenseDb = await _database.groupExpenseDAO.watch(groupId).first;
    final groupExpense = groupExpenseDb.toGroupExpenses();
    Iterable<GroupExpense> groupExpensesWithEvent = groupExpense;
    if (event is GroupExpense) {
      groupExpensesWithEvent = [...groupExpense, event];
    }

    final paymentsDb = await _database.paymentsDAO.watch(groupId).first;
    Iterable<Payment> payments = paymentsDb.toPayments();
    if (event is Payment) {
      payments = [...payments, event];
    }

    final debt = DebtCalculator(people, groupExpensesWithEvent, payments)
        .calculateEffectiveDebtForGroup();
    return debt;
  }
}
