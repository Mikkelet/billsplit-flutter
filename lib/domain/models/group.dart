import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/person.dart';

class Group {
  final String id;
  final String _name;
  final List<Person> people;
  final List<Person> pastMembers;
  final Person createdBy;
  final num timestamp;
  final Event? _latestEvent;
  final String _defaultCurrency;

  // modifiable values
  late String nameState = _name;
  late Event? latestEventState = _latestEvent;
  late String defaultCurrencyState = _defaultCurrency;

  Group(
      {required this.id,
      required String name,
      required this.people,
      required this.pastMembers,
      required this.createdBy,
      required this.timestamp,
      required Event? latestEvent,
      required String defaultCurrency})
      : _latestEvent = latestEvent,
        _name = name,
        _defaultCurrency = defaultCurrency;

  Iterable<Person> get allPeople => [...people, ...pastMembers];

  Group.newGroup(Person createdBy, String name, List<Person> people, String currency)
      : this(
          id: "",
          createdBy: createdBy,
          name: name,
          people: people,
          pastMembers: [],
          timestamp: DateTime.now().millisecondsSinceEpoch,
          latestEvent: null,
          defaultCurrency: currency,
        );

  Group.mock(num seed)
      : this(
            id: "G$seed",
            name: "Group $seed",
            pastMembers: [],
            people: [],
            createdBy: Person.dummy(2),
            timestamp: 0,
            defaultCurrency: "usd",
            latestEvent: null,);

  void reset() {
    nameState = _name;
    latestEventState = _latestEvent;
  }
}
