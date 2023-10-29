
import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/groups_mapper.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';


class DeleteExpenseUseCase {
  final _apiService = getIt<ApiService>();
  final _database = getIt<SplitsbyDatabase>();

  Future launch(String groupId, GroupExpense expense) async {
    final groupDb = await _database.groupsDAO.getGroup(groupId);
    final group = groupDb.toGroup();

    await _apiService.deleteExpense(group.toDTO(), expense.id);
    await _database.groupExpenseDAO.deleteExpense(expense.id);

    // update group
    await _database.groupsDAO.insertGroup(group.toDb());
  }
}
