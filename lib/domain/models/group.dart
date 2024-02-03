import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/mutable_state.dart';

class Group {
  final String id;
  final String _name;
  final String _coverImageUrl;
  final Iterable<Person> _people;
  final Iterable<Person> _pastMembers;
  final Iterable<Person> _invites;
  final Person createdBy;
  final num timestamp;
  final int _lastUpdated;
  final String _defaultCurrency;
  final int? lastSync;

  // modifiable values
  late final MutableState<String> nameState = _name.obs();
  late final MutableState<int> lastUpdatedState = _lastUpdated.obs();
  late final MutableState<String> defaultCurrencyState = _defaultCurrency.obs();
  late final MutableState<String> coverImageUrlState = _coverImageUrl.obs();
  late final MutableListState<Person> peopleState = _people.obsList();
  late final MutableListState<Person> pastMembersState = _pastMembers.obsList();
  late final MutableListState<Person> invitesState = _invites.obsList();

  Group(
      {required this.id,
      required String name,
      required String coverImageUrl,
      required Iterable<Person> people,
      required Iterable<Person> pastMembers,
      required Iterable<Person> invites,
      required this.createdBy,
      required this.timestamp,
      this.lastSync,
      required int lastUpdated,
      required String defaultCurrency})
      : _name = name,
        _invites = invites,
        _pastMembers = pastMembers,
        _people = people,
        _lastUpdated = lastUpdated,
        _coverImageUrl = coverImageUrl,
        _defaultCurrency = defaultCurrency;

  Iterable<Person> get allPeople => [...peopleState.value, ...pastMembersState.value];

  void respondToInvite(Person user, bool accept) {
    invitesState.remove(user);
    if (accept) {
      peopleState.add(user);
    }
  }

  void invitePerson(Person person) {
    invitesState.add(person);
  }

  Group.newGroup(
      Person createdBy, String name, Iterable<Person> people, String currency)
      : this(
          id: "",
          createdBy: createdBy,
          coverImageUrl: "",
          name: name,
          people: [createdBy],
          pastMembers: [],
          invites: people,
          timestamp: DateTime.now().millisecondsSinceEpoch,
          lastUpdated: DateTime.now().millisecondsSinceEpoch,
          defaultCurrency: currency,
        );

  Group.mock(num seed)
      : this(
          id: "G$seed",
          name: "Group $seed",
          coverImageUrl: "",
          pastMembers: [],
          people: [],
          invites: [],
          createdBy: Person.dummy(2),
          timestamp: 0,
          lastUpdated: 0,
          defaultCurrency: "usd",
        );
}
