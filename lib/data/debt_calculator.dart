import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/individual_expense.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:billsplit_flutter/utils/pair.dart';
import 'package:collection/collection.dart';

class DebtCalculator {
  final List<Person> people;
  final List<GroupExpense> expenses;
  final List<Payment> payments;
  late final expensesAndPayments = [
    ...expenses,
    ...payments.map((e) => e.toExpense())
  ];

  DebtCalculator(this.people, this.expenses, this.payments);

  DebtCalculator.fromCombined(Iterable<Person> people, Iterable<Event> events)
      : this(people.toList(), events.whereType<GroupExpense>().toList(),
            events.whereType<Payment>().toList());

  Iterable<Pair<Person, Iterable<Pair<Person, num>>>> calculateDebts() {
    return people.map((person) {
      // get expenses payed for by person
      final payedForGroupExpenses = expensesAndPayments
          .where((expense) => expense.payerState.uid == person.uid);
      // person cannot have debt to themselves
      final payedForExpensesWithoutPayee = payedForGroupExpenses
          .where((expense) => expense.payerState.uid == person.uid);
      // Update individual expenses to include the shared expense
      final Iterable<IndividualExpense> payedForIndividualExpenses =
          payedForExpensesWithoutPayee
              .map((expense) => expense.getIndividualWithShared())
              .flatMap();
      // get list of distinct indebted
      final distinctById = {
        for (var e in payedForIndividualExpenses) e.person.uid: e.person
      }.values;
      final accExpensesByIe = distinctById.map((indebted) {
        // for each distinct indebted, filter a list of their individual debts
        final debtsByIndebted = payedForIndividualExpenses
            .where((element) => element.person.uid == indebted.uid);
        // accumulate all their debts
        final totalDebt = debtsByIndebted.map((e) => e.expenseState).sum;
        return Pair(indebted, totalDebt);
      });
      return Pair(person, accExpensesByIe);
    });
  }

  Iterable<Pair<Person, Iterable<Pair<Person, num>>>> calculateDebtTo() {
    final allDebtsByPayer = calculateDebts();
    return allDebtsByPayer.map((debtsByPayer) {
      final payer = debtsByPayer.first;
      final owedByPayer = allDebtsByPayer
          .where((element) =>
              element.first.uid !=
              payer
                  .uid) // filter expenses not paid by payee, as payee cannot have debt to themselves
          .map((debts) {
        final indebted = debts.first;
        final debtToPayer = debts.second
            .where((element) => element.first.uid == payer.uid)
            .map((e) => e.second)
            .sum;
        return Pair(indebted, debtToPayer);
      });
      return Pair(payer, owedByPayer);
    });
  }

  Iterable<Pair<Person, num>> calculateEffectiveDebt(Person person) {
    final allDebt = calculateDebtTo();
    final payerDebt =
        allDebt.singleWhere((element) => element.first.uid == person.uid);
    final otherPayers =
        allDebt.where((element) => element.first.uid != person.uid);
    return otherPayers.map((otherPayer) {
      // filter payee debts to otherPayee and accumulate
      final otherPayerDebtToPayer = otherPayer.second
          .where((element) => element.first.uid == person.uid)
          .map((e) => e.second)
          .sum;

      // filter otherPayee debt to payee and accumulate
      final payerDebtToOtherPayer = payerDebt.second
          .where((element) => element.first.uid == otherPayer.first.uid)
          .map((e) => e.second)
          .sum;
      final effectiveDebt = payerDebtToOtherPayer - otherPayerDebtToPayer;
      return Pair(otherPayer.first, effectiveDebt);
    });
  }

  // POSSIBLE USES PAYMENTS TWICE, SINCE THEY'RE ALREADY INCLUDED
  Iterable<Pair<Person, num>> calculateDebtsAfterPayments(Person person) {
    // get debts owed by person
    final effectiveDebt = calculateEffectiveDebt(person);
    // for each debts, calculate the payment to negate potential debt
    return effectiveDebt.map((debt) {
      final debtee = debt.first;
      final debtAmount = debt.second;
      if (debtAmount > 0) {
        // if debt exists, find payments paid by person to debtee
        final paymentsByPerson = payments.where((element) =>
            element.createdBy.uid == person.uid &&
            element.paidTo.uid == debtee.uid);
        final accPayments = paymentsByPerson.map((e) => e.amount).sum;
        return Pair(debtee, debtAmount - accPayments);
      } else if (debtAmount < 0) {
        // if debt is owed TO person (negative debt), find payments made by debtee to person
        final paymentsToPerson = payments.where((element) =>
            element.paidTo.uid == person.uid &&
            element.createdBy.uid == debtee.uid);
        final accPayments = paymentsToPerson.map((e) => e.amount).sum;
        return Pair(debtee, debtAmount + accPayments);
      }
      return Pair(debtee, debtAmount);
    });
  }

  Iterable<Pair<String, num>> calculateEffectiveDebtForGroup() {
    return people.map((person) {
      return Pair(
          person.uid, calculateEffectiveDebt(person).map((e) => e.second).sum);
    });
  }

  num calculateTotalDebt() {
    return expenses.map((it) => it.total).sum;
  }

  void logCalculations() {
    print("Total expense: ${calculateTotalDebt()}");
    print("==== DEBT ====");
    calculateDebts().forEach((pair) {
      final payer = pair.first;
      final debts = pair.second;
      print("${payer.nameState} is owed:");
      for (var element in debts) {
        final indExpense = element.first;
        final debt = element.second;
        print("\t\$$debt by ${indExpense.nameState}");
      }
    });
    print("\n=== IND DEBT ===");
    calculateDebtTo().forEach((pair) {
      final payee = pair.first;
      final payeeDebts = pair.second;
      print("${payee.nameState} owes");
      for (var it in payeeDebts) {
        final ie = it.first;
        final debt = it.second;
        print("\t\$$debt to ${ie.nameState}");
      }
    });
    print("\n=== Effect Debt ===");
    expenses.map((e) => e.individualExpenses).flatMap().forEach((ie) {
      print("${ie.person.nameState} owes:");
      final person = ie.person;
      final debt = calculateEffectiveDebt(person);
      for (var it in debt) {
        print("\tto ${it.first.nameState}: \$${it.second}");
      }
    });
    print("\n=== After Payments ===");
    print("");
    for (var it in payments) {
      print(
          "${it.createdBy.nameState} paid \$${it.amount} to ${it.paidTo.nameState}");
    }
    print("");
    for (var person in people) {
      print("Debts for ${person.nameState}");
      calculateDebtsAfterPayments(person).forEach((element) {
        final otherPerson = element.first;
        final debt = element.second;
        if (debt > 0) {
          print(
              "\t${otherPerson.nameState} owes \$$debt to ${person.nameState}");
        } else if (debt < 0) {
          print(
              "\t${person.nameState} owes \$$debt to ${otherPerson.nameState}");
        }
      });
    }
  }
}

extension GroupExpenseExt on GroupExpense {

  Iterable<IndividualExpense> getIndividualWithShared() =>
      individualExpenses.map((e) {
        final expense = e.expenseState + getSharedExpensesForPerson(e.person);
        return IndividualExpense(
            person: e.person,
            expense: expense);
      });
}

extension PaymentExt on Payment {
  GroupExpense toExpense() => GroupExpense(
        id: id,
        createdBy: createdBy,
        timestamp: timestamp,
        description: "",
        payer: createdBy,
        sharedExpenses: [],
        individualExpenses: [
          IndividualExpense(person: paidTo, expense: amount)
        ],
      );
}
