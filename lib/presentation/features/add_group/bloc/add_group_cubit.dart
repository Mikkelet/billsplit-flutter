import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/friend.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/use_cases/add_group_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/get_friends_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/observe_friends_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/features/add_group/bloc/add_group_state.dart';

class LoadingFriends extends Main {}

class AddGroupCubit extends BaseCubit {
  String groupName = "";
  String currency = Currency.USD().symbol;
  late final List<Person> _people = [user];
  final _observeFriendsUseCase = ObserveFriendsUseCase();
  final _getFriendsUseCase = GetFriendsUseCase();
  final _addGroupUseCase = AddGroupUseCase();

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

  void loadFriends() {
    emit(LoadingFriends());
    _getFriendsUseCase.launch().then((value) {
      emit(Main());
    }).catchError((err, st) {
      showError(err, st);
    });
  }

  void addGroup() {
    final group = Group.newGroup(user, groupName, people, currency);
    showLoading();
    _addGroupUseCase.launch(group).then((value) {
      emit(GroupAdded(value));
    }).catchError((error, st) {
      showError(error, st);
    });
  }

  void updateCurrency(Currency currency) {
    this.currency = currency.symbol;
    emit(Main());
  }
}
