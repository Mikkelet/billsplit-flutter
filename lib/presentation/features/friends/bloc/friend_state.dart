import 'package:billsplit_flutter/presentation/features/friends/bloc/friends_cubit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:billsplit_flutter/presentation/base/errors.dart';

part '../../../../_generated/presentation/features/friends/bloc/friend_state.freezed.dart';

@freezed
abstract class FriendsState with _$FriendsState {
  const factory FriendsState({
    @Default(false) bool isLoading,
    @Default(SplitsbyError.none()) SplitsbyError error,
    @Default(AddFriendType.none) AddFriendType selectedAddFriendType,
    @Default("") String dialCode,
  }) = _FriendsState;
}
