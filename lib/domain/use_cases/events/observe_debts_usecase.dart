import 'package:billsplit_flutter/data/debt_calculator.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/repositories/auth_repository.dart';
import 'package:billsplit_flutter/domain/use_cases/currency/convert_currency_use_case.dart';
import 'package:billsplit_flutter/domain/use_cases/events/observe_events_usecase.dart';
import 'package:billsplit_flutter/utils/pair.dart';

class ObserveDebtsUseCase {
  final _authRepository = getIt<AuthRepository>();
  final _observeEventsUseCase = ObserveEventsUseCase();
  final _convertCurrencyUseCase = ConvertCurrencyUseCase();

  /// returns a list of debts to user denoted in group's default currency
  Stream<Iterable<Pair<Person, num>>> observe(Group group) {
    return _observeEventsUseCase.observe(group.id).map((events) {
      if (events.isEmpty) return [];
      final temps = _getTemps(events.whereType<GroupExpense>());
      final people = {
        ...group.peopleState.value,
        ...group.pastMembersState.value,
        ...temps
      };
      final calculator = DebtCalculator.fromCombined(people, events);
      final user = _authRepository.loggedInUser;
      final debts = calculator.calculateEffectiveDebt(user);
      final debtsConverted = debts.map((e) {
        final converted = _convertCurrencyUseCase.launch(
          e.second,
          Currency.usd().symbol,
          group.defaultCurrencyState.value,
        );
        return Pair(e.first, converted);
      });
      return debtsConverted.where((element) => element.second != 0);
    });
  }

  Iterable<Person> _getTemps(Iterable<GroupExpense> expenses) {
    return expenses.fold(
        [],
        (previousValue, element) =>
            [...previousValue, ...element.tempParticipantsState.value]);
  }
}
