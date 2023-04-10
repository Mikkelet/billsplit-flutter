import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/data/remote/dtos/event_dto.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/event_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/group_expense_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/payment_mapper.dart';
import 'package:billsplit_flutter/domain/models/event.dart';

class AddEventUseCase {
  final _apiService = getIt<ApiService>();
  final _database = getIt<SplitsbyDatabase>();

  Future<Event?> launch(String groupId, Event event) async {
    final response =
        await _apiService.addEvent(groupId, event.toEventDTO(), []);
    final EventDTO eventDto = response.event!;
    if (eventDto is GroupExpenseDTO) {
      final expenseDb = eventDto.toDb(groupId);
      await _database.groupExpenseDAO.insert(expenseDb);
    } else if (eventDto is PaymentDTO) {
      final paymentDb = eventDto.toDb(groupId);
      await _database.paymentsDAO.insert(paymentDb);
    }
    return event;
  }
}
