import 'package:billsplit_flutter/data/auth/auth_provider.dart';
import 'package:billsplit_flutter/data/debt_calculator.dart';
import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/groups_mapper.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/use_cases/observe_events_usecase.dart';
import 'package:billsplit_flutter/utils/pair.dart';

class ObserveDebtsUseCase {
  final _database = getIt<SplitsbyDatabase>();
  final _authProvider = getIt<AuthProvider>();
  final _observeEventsUseCase = ObserveEventsUseCase();

  Stream<Iterable<Pair<Person, num>>> observe(String groupId) {
    return _observeEventsUseCase.observe(groupId).asyncMap((event) async {
      final response = await _database.groupsDAO.getGroup(groupId);
      final group = response.toGroup();
      final calculator = DebtCalculator.fromCombined(group.people, event);
      final user = await _authProvider.authListener().first;
      final debts = calculator.calculateDebtsAfterPayments(Person(user!, ""));
      return debts.where((element) => element.second != 0);
    });
  }
}
