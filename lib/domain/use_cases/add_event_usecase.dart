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
  final String _groupId;
  final Event _event;

  AddEventUseCase(this._groupId, this._event);

  Future launch() async {
    final debtForGroup = (await _getDebtWithAddedEvent())
        .map((e) => DebtDTO(e.first, e.second))
        .toList();


    final response = await _apiService.addEvent(_groupId, _event.toEventDTO(), debtForGroup);

    final EventDTO eventDto = response.event!;

    if (eventDto is GroupExpenseDTO) {
      final expenseDb = eventDto.toDb(_groupId);
      await _database.groupExpenseDAO.insert(expenseDb);
    } else if (eventDto is PaymentDTO) {
      final paymentDb = eventDto.toDb(_groupId);
      await _database.paymentsDAO.insert(paymentDb);
    }
  }

  Future<Iterable<Pair<String, num>>> _getDebtWithAddedEvent() async {
    final groupDb = (await _database.groupsDAO.getGroup(_groupId)).toGroup();
    final people = groupDb.people.toList();
    final groupExpenses =
        (await _database.groupExpenseDAO.watch(_groupId).first)
            .toGroupExpenses();
    List<GroupExpense> groupExpensesWithEvent = groupExpenses.toList();
    if (_event is GroupExpense) {
      groupExpensesWithEvent = [...groupExpenses, _event as GroupExpense];
    }
    final payments = (await _database.paymentsDAO.watch(_groupId).first)
        .toPayments()
        .toList();
    final debt = DebtCalculator(people, groupExpensesWithEvent, payments)
        .calculateEffectiveDebtForGroup();
    return debt;
  }
}
