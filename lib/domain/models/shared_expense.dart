import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../_generated/domain/models/shared_expense.freezed.dart';

@freezed
abstract class SharedExpense with _$SharedExpense {
  const factory SharedExpense({
    @Default(0) num expense,
    @Default([]) List<Person> participants,
    @Default("") String description,
  }) = _SharedExpense;

  const SharedExpense._();

  num get sharedExpenseDivided {
    try {
      return expense / participants.length;
    } catch (e) {
      return 0;
    }
  }
}
