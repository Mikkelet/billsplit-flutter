import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/friend.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/use_cases/friends/get_friends_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/friends/observe_friends_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/groups/add_group_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/safe_cubit.dart';
import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:billsplit_flutter/presentation/features/add_group/bloc/add_group_state.dart';
import 'package:flutter/cupertino.dart';

class AddGroupCubit extends SafeCubit<AddGroupState> {
  final _observeFriendsUseCase = ObserveFriendsUseCase();
  final _getFriendsUseCase = GetFriendsUseCase();
  final _addGroupUseCase = AddGroupUseCase();
  final nameTextController = TextEditingController();

  AddGroupCubit() : super(AddGroupState());

  void onAddPerson(Person person) {
    final copy = List.of(state.people);
    copy.add(person);
    safeEmit(state.copyWith(people: copy));
  }

  void removePerson(Person person) {
    final copy = List.of(state.people);
    copy.remove(person);
    safeEmit(state.copyWith(people: copy));
  }

  late Stream<Iterable<Person>> friendsStream = _observeFriendsUseCase.observe().map(
        (friends) =>
        friends
            .where((friend) => friend.status == FriendStatus.accepted)
            .map((friend) => friend.person)
            .toSet()
            .difference(state.people.toSet()),
  );

  Future<void> loadFriends() async {
    try {
      safeEmit(state.copyWith(isLoading: true));
      await _getFriendsUseCase.launch();
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.unknown(e.toString())));
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }

  void addGroup() async {
    try {
      final group = Group(
        name: state.groupName,
        people: state.people,
        defaultCurrency: state.currency,
      );
      safeEmit(state.copyWith(isLoading: true));
      await _addGroupUseCase.launch(group);
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.unknown(e.toString())));
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }

  void updateCurrency(Currency currency) {
    safeEmit(state.copyWith(currency: currency.symbol));
  }

  @override
  Future<void> close() async {
    nameTextController.dispose();
    return super.close();
  }
}
