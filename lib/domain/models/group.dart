import 'package:billsplit_flutter/domain/models/debt.dart';
import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';

class Group {
  final String id;
  final String name;
  final List<Person> people;
  final Person createdBy;
  final num timestamp;
  final Event? latestEvent;
  final List<Debt> debts;

  Group({required this.id,
    required this.name,
    required this.people,
    required this.createdBy,
    required this.timestamp,
    required this.latestEvent,
    required this.debts});

  Group.newGroup(Person createdBy, String name, List<Person> people) : this(
    id: "",
    createdBy: createdBy,
    name: name,
    people: people,
    timestamp: DateTime
        .now()
        .millisecondsSinceEpoch,
    latestEvent: null,
    debts: [],
  );

  Group.mock(num seed)
      : this(
      id: "G$seed",
      name: "Group $seed",
      people: [],
      createdBy: Person.dummy(2),
      timestamp: 0,
      latestEvent: null,
      debts: []);
}
