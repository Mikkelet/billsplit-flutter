import 'dart:convert';

import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/dtos/event_dto.dart';
import 'package:billsplit_flutter/domain/mappers/currency_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/event_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/person_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/shared_expense_mapper.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/sync_state.dart';

extension GroupExpensesDtoExt on Iterable<GroupExpenseDTO> {
  Iterable<GroupExpenseDb> toDb(String groupId) =>
      map((e) => e.toDb(groupId, SyncState.synced)).toList();
}

extension GroupExpenseDtoExt on GroupExpenseDTO {
  GroupExpenseDb toDb(String groupId, SyncState syncState) => GroupExpenseDb(
      id: id,
      groupId: groupId,
      groupExpense: json.encode(this),
      syncState: syncState.index);

  GroupExpense toGroupExpense() => GroupExpense(
      id: id,
      createdBy: createdBy.toPerson(),
      timestamp: timestamp,
      tempParticipants: tempParticipants.toPeople(),
      receiptImageUrl: receiptImageUrl,
      date: DateTime.parse(date),
      description: description,
      payer: payee.toPerson(),
      currency: currency.toCurrency(),
      syncState: SyncState.synced,
      sharedExpenses: sharedExpenses.toSharedExpense());
}

extension GroupExpensesDbExt on Iterable<GroupExpenseDb> {
  Iterable<GroupExpense> toGroupExpenses() => map((e) => e.toGroupExpense());
}

extension GroupExpenseDbExt on GroupExpenseDb {
  GroupExpenseDTO toDTO() =>
      GroupExpenseDTO.fromJson(json.decode(groupExpense));

  GroupExpense toGroupExpense() {
    final dto = GroupExpenseDTO.fromJson(json.decode(groupExpense));
    return GroupExpense(
        id: id,
        createdBy: dto.createdBy.toPerson(),
        timestamp: dto.timestamp,
        tempParticipants: dto.tempParticipants.toPeople(),
        description: dto.description,
        date: DateTime.parse(dto.date),
        receiptImageUrl: dto.receiptImageUrl,
        sharedExpenses: dto.sharedExpenses.toSharedExpense(),
        payer: dto.payee.toPerson(),
        syncState: SyncState.fromId(syncState),
        currency: dto.currency.toCurrency());
  }
}

extension GroupExpenseExt on GroupExpense {
  GroupExpenseDb toDb(String groupId, SyncState syncState, {String? tempId}) {
    return GroupExpenseDb(
        id: tempId ?? id,
        groupId: groupId,
        groupExpense: jsonEncode(toEventDTO().toJson()),
        syncState: syncState.index);
  }
}
