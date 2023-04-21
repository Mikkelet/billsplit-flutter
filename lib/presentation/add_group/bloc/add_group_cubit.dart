import 'package:billsplit_flutter/domain/models/friend.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/use_cases/observe_friends_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';

class AddGroupCubit extends BaseCubit {
  late final List<Person> _people = [user];
  final _observeFriendsUseCase = ObserveFriendsUseCase();

  void onAddPerson(Person person) {
    _people.add(person);
    emit(Main());
  }

  void removePerson(Person person) {
    _people.remove(person);
    emit(Main());
  }

  late Stream<Iterable<Person>> friendsStream = _observeFriendsUseCase
      .observe()
      .map((friends) => friends
          .where((friend) => friend.status == FriendStatus.accepted)
          .map((friend) => friend.person)
          .toSet()
          .difference(_people.toSet()));

  List<Person> get people => _people;

}
