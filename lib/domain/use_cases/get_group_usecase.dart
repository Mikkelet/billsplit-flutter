import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/data/remote/dtos/event_dto.dart';
import 'package:billsplit_flutter/domain/mappers/event_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/group_expense_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/groups_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/payment_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/service_mapper.dart';

class GetGroupUseCase {
  final _apiService = ApiService();
  final _database = SplitsbyDatabase.instance;

  Future<Map<String, dynamic>> launch(String groupId) async {
    final response = await _apiService.getGroup(groupId);
    print(response.group);
    print(response.events);
    print(response.services);
    await _database.servicesDao.insertAll(response.services.toDb(groupId));
    await _database.groupsDAO.insertGroup(response.group.toDb());

    final List<GroupExpenseDTO> groupExpenses =
        response.events.whereType<GroupExpenseDTO>().toList();
    final Iterable<PaymentDTO> payments = response.events.whereType<PaymentDTO>();
    await _database.groupExpenseDAO.clearForGroup(groupId);
    await _database.paymentsDAO.clearForGroup(groupId);
    await _database.groupExpenseDAO.insertAll(groupExpenses.toDb(groupId));
    await _database.paymentsDAO.insertAll(payments.toDb(groupId));

    return {
      "group": response.group.toGroup(),
      "events": response.events.toEvents(),
      "services": response.services.toServices()
    };
  }
}
