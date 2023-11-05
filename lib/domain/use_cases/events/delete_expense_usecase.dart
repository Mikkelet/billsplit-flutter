
import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';


class DeleteExpenseUseCase {
  final _apiService = getIt<ApiService>();
  final _database = getIt<SplitsbyDatabase>();

  Future launch(String groupId, GroupExpense expense) async {
    await _apiService.deleteExpense(groupId, expense.id);
    await _database.groupExpenseDAO.deleteExpense(expense.id);

    // update group
    await _database.groupsDAO.updateLastSynced(groupId);
  }
}
