import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/data/remote/dtos/event_dto.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/group_expense_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/payment_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/service_mapper.dart';

class GetEventsUseCase {
  final _apiService = getIt<ApiService>();
  final _database = getIt<SplitsbyDatabase>();

  Future launch(String groupId) async {
    final response = await _apiService.getEvents(groupId);

    await _database.servicesDao.clearForGroup(groupId);
    await _database.servicesDao.insertAll(response.services.toDb(groupId));

    final Iterable<GroupExpenseDTO> groupExpenses =
        response.events.whereType<GroupExpenseDTO>();
    await _database.groupExpenseDAO.clearForGroup(groupId);
    await _database.groupExpenseDAO.insertAll(groupExpenses.toDb(groupId));

    final Iterable<PaymentDTO> payments =
        response.events.whereType<PaymentDTO>();
    await _database.paymentsDAO.clearForGroup(groupId);
    await _database.paymentsDAO.insertAll(payments.toDb(groupId));

    await _database.groupsDAO.updateLastSynced(groupId);
  }
}
