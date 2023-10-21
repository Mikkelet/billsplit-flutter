import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/data/remote/dtos/event_dto.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/group_expense_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/groups_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/payment_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/service_mapper.dart';

class GetGroupUseCase {
  final _apiService = getIt<ApiService>();
  final _database = getIt<SplitsbyDatabase>();

  Future<void> launch(String groupId) async {
    final response = await _apiService.getGroup(groupId);
    final shouldSync = await _shouldSync(groupId);
    if (!shouldSync) return;
    await _database.groupsDAO.insertGroup(response.group.toDb());

    await _database.servicesDao.clearForGroup(groupId);
    await _database.servicesDao.insertAll(response.services.toDb(groupId));

    final Iterable<GroupExpenseDTO> groupExpenses =
        response.events.whereType<GroupExpenseDTO>().toList();
    await _database.groupExpenseDAO.clearForGroup(groupId);
    await _database.groupExpenseDAO.insertAll(groupExpenses.toDb(groupId));

    final Iterable<PaymentDTO> payments =
        response.events.whereType<PaymentDTO>();
    await _database.paymentsDAO.clearForGroup(groupId);
    await _database.paymentsDAO.insertAll(payments.toDb(groupId));

    await _database.groupsDAO.updateLastSynced(groupId);
  }

  Future<bool> _shouldSync(String groupId) async {
    final groupDb = await _database.groupsDAO.getGroup(groupId);
    final group = groupDb.toGroup();
    final lastSynced = groupDb.lastUpdated;
    final lastUpdated = group.lastUpdatedState;
    print("qqq lastSync=$lastSynced");
    print("qqq lastUpdate=$lastUpdated");
    print("qqq shouldUpdate=${lastUpdated > (lastSynced ?? 0)}");
    if(lastSynced == null) return true;
    return lastUpdated > lastSynced;
  }
}
