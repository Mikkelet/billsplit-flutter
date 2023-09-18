import 'package:billsplit_flutter/data/currency_converter.dart';
import 'package:billsplit_flutter/data/debt_calculator.dart';
import 'package:billsplit_flutter/data/local/preferences/shared_prefs.dart';
import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/group_expense_event.dart';
import 'package:billsplit_flutter/domain/models/individual_expense.dart';
import 'package:billsplit_flutter/domain/models/payment_event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/shared_expense.dart';
import 'package:billsplit_flutter/domain/models/sync_state.dart';
import 'package:collection/collection.dart';
import 'package:get_it/get_it.dart';

final samplePeopleShera = [
  Person("0", "Aang"),
  Person("1", "Toph"),
  Person("2", "Katara"),
];

final sampleGroup = Group(
    id: "GROUP0",
    name: "My group",
    pastMembers: [],
    defaultCurrency: "usd",
    people: samplePeopleShera,
    createdBy: samplePeopleShera.first,
    timestamp: 0,
    latestEvent: null);

final sampleIndividualExpenses = samplePeopleShera.toList().mapIndexed(
    (i, p) => IndividualExpense(currency: "usd", person: p, expense: i * 100));

final sampleSharedExpense = [
  SharedExpense(
      expense: sampleIndividualExpenses.length * 200,
      participants: samplePeopleShera,
      description: "")
];

List<GroupExpense> get sampleSharedExpenses {
  return [
    GroupExpense(
        id: "0",
        createdBy: samplePeopleShera[2],
        description: "Taking down the fire nation",
        payer: samplePeopleShera[0],
        timestamp: 1,
        tempParticipants: [],
        currency: Currency(symbol: "usd", rate: 1),
        syncState: SyncState.synced,
        sharedExpenses: sampleSharedExpense),
    GroupExpense(
      id: "1",
      createdBy: samplePeopleShera[2],
      description: "Beach day",
      payer: samplePeopleShera[1],
      tempParticipants: [],
      currency: Currency(symbol: "usd", rate: 1),
      timestamp: 2,
      syncState: SyncState.synced,
      sharedExpenses: sampleSharedExpense,
    ),
    GroupExpense(
        id: "2",
        createdBy: samplePeopleShera[1],
        description: "Appa haircut",
        payer: samplePeopleShera[2],
        timestamp: 3,
        tempParticipants: [],
        currency: Currency(symbol: "usd", rate: 1),
        syncState: SyncState.synced,
        sharedExpenses: sampleSharedExpense),
    GroupExpense(
        id: "3",
        createdBy: samplePeopleShera[0],
        description: "",
        payer: samplePeopleShera[2],
        timestamp: 4,
        tempParticipants: [],
        currency: Currency(symbol: "usd", rate: 1),
        syncState: SyncState.synced,
        sharedExpenses: sampleSharedExpense),
    GroupExpense(
        id: "4",
        createdBy: samplePeopleShera[0],
        description: "Foods",
        payer: samplePeopleShera[2],
        tempParticipants: [],
        timestamp: 5,
        currency: Currency(symbol: "usd", rate: 1),
        syncState: SyncState.synced,
        sharedExpenses: sampleSharedExpense),
  ];
}

List<Payment> get samplePayments {
  final person1 = samplePeopleShera[0];
  final person2 = samplePeopleShera[1];
  final person3 = samplePeopleShera[2];

  return [
    Payment(
      id: "",
      createdBy: person2,
      paidBy: person2,
      timestamp: 6,
      currency: Currency(symbol: "usd", rate: 1),
      paidTo: person3,
      amount: 500,
    ),
    Payment(
      id: "",
      createdBy: person1,
      paidBy: person1,
      currency: Currency(symbol: "usd", rate: 1),
      timestamp: 7,
      paidTo: person3,
      amount: 200,
    ),
    Payment(
      id: "",
      createdBy: person2,
      paidBy: person2,
      currency: Currency(symbol: "usd", rate: 1),
      timestamp: 8,
      paidTo: person1,
      amount: 100,
    ),
  ];
}

void main() {
  GetIt.instance.registerSingleton(SharedPrefs());
  GetIt.instance.registerSingleton(CurrencyConverter());

  final debtCalculator =
      DebtCalculator(samplePeopleShera, sampleSharedExpenses, samplePayments);

  print("Total expense: ${debtCalculator.calculateTotalDebt()}");
  print("==== DEBT ====");
  debtCalculator.calculateDebts().forEach((pair) {
    final payer = pair.first;
    final debts = pair.second;
    print("${payer.displayName} is owed:");
    debts.forEach((element) {
      final indExpense = element.first;
      final debt = element.second;
      print("\t\$$debt by ${indExpense.displayName}");
    });
  });
  print("\n=== IND DEBT ===");
  debtCalculator.calculateDebtTo().forEach((pair) {
    final payee = pair.first;
    final payeeDebts = pair.second;
    print("${payee.displayName} owes");
    payeeDebts.forEach((it) {
      final ie = it.first;
      final debt = it.second;
      print("\t\$$debt to ${ie.displayName}");
    });
  });
  print("\n=== Effect Debt ===");
  sampleIndividualExpenses.forEach((ie) {
    print("${ie.person.displayName} owes:");
    final person = ie.person;
    final debt = debtCalculator.calculateEffectiveDebt(person);
    debt.forEach((it) {
      print("\tto ${it.first.displayName}: \$${it.second}");
    });
  });
  print("\n=== After Payments ===");
  print("");
  samplePayments.forEach((it) {
    print(
        "${it.createdBy.displayName} paid \$${it.amount} to ${it.paidTo.displayName}");
  });
  print("");
  samplePeopleShera.forEach((person) {
    print("Debts for ${person.displayName}");
    debtCalculator.calculateDebtsAfterPayments(person).forEach((element) {
      final otherPerson = element.first;
      final debt = element.second;
      if (debt > 0)
        print("\t${otherPerson.displayName} owes \$$debt to ${person.displayName}");
      else if (debt < 0)
        print("\t${person.displayName} owes \$$debt to ${otherPerson.displayName}");
    });
  });
}
