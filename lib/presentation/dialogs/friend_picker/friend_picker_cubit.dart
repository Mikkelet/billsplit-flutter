import 'package:billsplit_flutter/domain/models/friend.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/use_cases/friends/get_friends_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/friends/observe_friends_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/safe_cubit.dart';
import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../_generated/presentation/dialogs/friend_picker/friend_picker_cubit.freezed.dart';

class FriendPickerCubit extends SafeCubit<FriendsPickerState> {
  final _observeFriendsUseCase = ObserveFriendsUseCase();
  final _getFriendsUseCase = GetFriendsUseCase();
  final List<Person> currentPickedFriends;

  FriendPickerCubit(this.currentPickedFriends) : super(FriendsPickerState());

  Stream<Iterable<Person>> get friendsStream =>
      _observeFriendsUseCase.observe()
          .map((friends) => friends
          .where((friend) => friend.status == FriendStatus.accepted)
          .map((friend) => friend.person)
          .toSet()
          .difference(currentPickedFriends.toSet()));

  void onLoadFriends() async {
    try {
        safeEmit(state.copyWith(isLoading: true));
        await _getFriendsUseCase.launch();
    } catch(e, st) {
        logError(e, st);
        safeEmit(state.copyWith(error: SplitsbyError.serverError(e.toString())));
    } finally {
        safeEmit(state.copyWith(isLoading: false));
    }
  }
}


@freezed
abstract class FriendsPickerState with _$FriendsPickerState {
  const factory FriendsPickerState({
    @Default(false) bool isLoading,
    @Default(SplitsbyError.none()) SplitsbyError error,
  }) = _FriendsPickerState;
}