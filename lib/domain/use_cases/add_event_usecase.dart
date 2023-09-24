import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/data/remote/dtos/event_dto.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/event_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/group_expense_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/payment_mapper.dart';
import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/sync_state.dart';
import 'package:billsplit_flutter/utils/constants.dart';

class AddEventUseCase {
  final _apiService = getIt<ApiService>();
  final _database = getIt<SplitsbyDatabase>();

  Future launch(String groupId, Event event) async {
    // store pending event in db, will be updated later
    String tempId =
        event.id.isEmpty ? "$tempIdPrefix-${event.hashCode}" : event.id;
    if (event is GroupExpense) {
      final expenseDb = event.toDb(groupId, SyncState.pending, tempId: tempId);
      await _database.groupExpenseDAO.insert(expenseDb);
    }

    try {
      final response = await _apiService.addEvent(groupId, event.toEventDTO());
      final EventDTO eventDto = response.event!;

      if (eventDto is GroupExpenseDTO) {
        final expenseDb = eventDto.toDb(groupId, SyncState.synced);
        await _database.groupExpenseDAO.deleteExpense(tempId);
        await _database.groupExpenseDAO.insert(expenseDb);
      } else if (eventDto is PaymentDTO) {
        final paymentDb = eventDto.toDb(groupId);
        await _database.paymentsDAO.insert(paymentDb);
      }
    } catch (e) {
      if (event is GroupExpense) {
        final expenseDb = event.toDb(groupId, SyncState.failed, tempId: tempId);
        await _database.groupExpenseDAO.insert(expenseDb);
      }
      rethrow;
    }
  }
}
