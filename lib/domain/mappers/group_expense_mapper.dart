import 'dart:convert';

import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/dtos/event_dto.dart';
import 'package:billsplit_flutter/domain/mappers/individual_expense_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/person_mapper.dart';
import 'package:billsplit_flutter/domain/models/event.dart';

extension GroupExpensesDtoExt on Iterable<GroupExpenseDTO> {
  Iterable<GroupExpenseDb> toDb(String groupId) =>
      map((e) => e.toDb(groupId)).toList();
}

extension GroupExpenseDtoExt on GroupExpenseDTO {
  GroupExpenseDb toDb(String groupId) =>
      GroupExpenseDb(id: id, groupId: groupId, groupExpense: json.encode(this));

  GroupExpense toGroupExpense() => GroupExpense(
      id: id,
      createdBy: createdBy.toPerson(),
      timestamp: timeStamp,
      description: description,
      payer: payee.toPerson(),
      sharedExpense: sharedExpense,
      individualExpenses:
          individualExpenses.map((e) => e.toExpense()).toList());
}

extension GroupExpensesDbExt on Iterable<GroupExpenseDb> {
  Iterable<GroupExpense> toGroupExpenses() => map((e) => e.toGroupExpense());
}

extension GroupExpenseDbExt on GroupExpenseDb {
  GroupExpenseDTO toDTO() =>
      GroupExpenseDTO.fromJson(json.decode(groupExpense));

  GroupExpense toGroupExpense() => toDTO().toGroupExpense();
}
