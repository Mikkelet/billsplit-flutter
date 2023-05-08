
import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/data/remote/dtos/debts_dto.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/debts_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/group_expense_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/groups_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/payment_mapper.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/utils/pair.dart';

import '../../data/debt_calculator.dart';

class DeleteExpenseUseCase {
  final _apiService = getIt<ApiService>();
  final _database = getIt<SplitsbyDatabase>();

  Future launch(String groupId, GroupExpense expense) async {
    final groupDb = await _database.groupsDAO.getGroup(groupId);
    final group = groupDb.toGroup();
    final debtForGroup =
        await _getDebtWithoutExpense(groupId, expense, group.people);
    final debtDTO = debtForGroup.map((e) => DebtDTO(e.first, e.second));

    await _apiService.deleteExpense(group.toDTO(), expense.id, debtDTO);
    await _database.groupExpenseDAO.deleteExpense(expense.id);

    // update group
    group.debtState = debtDTO.toDebts();
    await _database.groupsDAO.insertGroup(group.toDb());
  }

  Future<Iterable<Pair<String, num>>> _getDebtWithoutExpense(
      String groupId, GroupExpense event, List<Person> people) async {
    final groupExpenseDb = await _database.groupExpenseDAO.watch(groupId).first;
    // expenses
    final groupExpense = groupExpenseDb.toGroupExpenses();
    final groupExpensesWithoutExpense =
        groupExpense.where((element) => element.id != event.id);
    // payments
    final paymentsDb = await _database.paymentsDAO.watch(groupId).first;
    final payments = paymentsDb.toPayments();

    final debt = DebtCalculator(people, groupExpensesWithoutExpense, payments)
        .calculateEffectiveDebtForGroup();
    return debt;
  }
}
