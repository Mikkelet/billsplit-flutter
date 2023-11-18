import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/group_expense_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/payment_mapper.dart';
import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/payment_event.dart';
import 'package:billsplit_flutter/domain/presentation_data.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:rxdart/rxdart.dart';

class ObserveEventsUseCase {
  final _database = getIt<SplitsbyDatabase>();

  Stream<Iterable<Event>> observe(String groupId) {
    if(groupId == "hiking") return Stream.value(hikingExpenses);
    if(groupId == "home") return Stream.value(hikingExpenses);
    if(groupId == "thailand") return Stream.value(thailandExpenses);
    if(groupId == "bday") return Stream.value(hikingExpenses);
    return Stream.value([]);
  }
}
