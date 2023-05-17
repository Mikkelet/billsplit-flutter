import 'package:billsplit_flutter/domain/models/friend.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/use_cases/get_friends_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/observe_friends_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';

class FriendPickerCubit extends BaseCubit {
  final _observeFriendsUseCase = ObserveFriendsUseCase();
  final _getFriendsUseCase = GetFriendsUseCase();
  final Iterable<Person> currentPickedFriends;

  FriendPickerCubit(this.currentPickedFriends);

  Stream<Iterable<Person>> get friendsStream =>
      _observeFriendsUseCase.observe()
          .map((friends) => friends
          .where((friend) => friend.status == FriendStatus.accepted)
          .map((friend) => friend.person)
          .toSet()
          .difference(currentPickedFriends.toSet()));

  void onLoadFriends() {
    showLoading();
    _getFriendsUseCase.launch().then((value) {
      emit(Main());
    }).catchError((err, st) {
      showError(err, st);
    });
  }
}
