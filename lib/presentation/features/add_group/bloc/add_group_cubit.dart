import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/friend.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/use_cases/friends/get_friends_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/friends/observe_friends_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/groups/add_group_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/features/add_group/bloc/add_group_state.dart';
import 'package:billsplit_flutter/presentation/mutable_state.dart';

class LoadingFriends extends Main {}

class AddGroupCubit extends BaseCubit {
  final _observeFriendsUseCase = ObserveFriendsUseCase();
  final _getFriendsUseCase = GetFriendsUseCase();
  final _addGroupUseCase = AddGroupUseCase();

  final groupName = "".obs();
  final currency = Currency.usd().symbol.obs();
  final people = <Person>[].obsList();

  void onAddPerson(Person person) {
    people.add(person);
  }

  void removePerson(Person person) {
    people.remove(person);
  }

  late Stream<Iterable<Person>> friendsStream = _observeFriendsUseCase
      .observe()
      .map((friends) => friends
          .where((friend) => friend.status == FriendStatus.accepted)
          .map((friend) => friend.person)
          .toSet()
          .difference(people.value.toSet()));

  void loadFriends() {
    emit(LoadingFriends());
    _getFriendsUseCase.launch().then((value) {
      emit(Main());
    }).catchError((err, st) {
      showError(err, st);
    });
  }

  void addGroup() {
    final group =
        Group.newGroup(user, groupName.value, people.value, currency.value);
    showLoading();
    _addGroupUseCase.launch(group).then((value) {
      emit(GroupAdded(value));
    }).catchError((error, st) {
      showError(error, st);
    });
  }

  void updateCurrency(Currency currency) {
    this.currency.value = currency.symbol;
  }

  void onUpdateGroupName(String name) {
    groupName.value = name;
  }
}
