import 'package:billsplit_flutter/domain/models/debt.dart';
import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';

class Group {
  final String id;
  final String name;
  final List<Person> people;
  final List<Person> pastMembers;
  final Person createdBy;
  final num timestamp;
  final Event? _latestEvent;
  final List<Debt> _debts;

  // modifiable values
  late Event? latestEventState = _latestEvent;
  late Iterable<Debt> debtState = _debts;

  Group(
      {required this.id,
      required this.name,
      required this.people,
      required this.pastMembers,
      required this.createdBy,
      required this.timestamp,
      required Event? latestEvent,
      required Iterable<Debt> debts})
      : _latestEvent = latestEvent,
        _debts = debts.toList();

  Iterable<Person> get allPeople => [...people, ...pastMembers];

  Group.newGroup(Person createdBy, String name, List<Person> people)
      : this(
          id: "",
          createdBy: createdBy,
          name: name,
          people: people,
          pastMembers: [],
          timestamp: DateTime.now().millisecondsSinceEpoch,
          latestEvent: null,
          debts: [],
        );

  Group.mock(num seed)
      : this(
            id: "G$seed",
            name: "Group $seed",
            pastMembers: [],
            people: [],
            createdBy: Person.dummy(2),
            timestamp: 0,
            latestEvent: null,
            debts: []);
}
