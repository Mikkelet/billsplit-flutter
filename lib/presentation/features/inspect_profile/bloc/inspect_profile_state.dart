import 'package:billsplit_flutter/domain/models/friend.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../_generated/presentation/features/inspect_profile/bloc/inspect_profile_state.freezed.dart';

@freezed
abstract class InspectProfileState with _$InspectProfileState {
  const factory InspectProfileState({
    @Default(false) bool isLoading,
    @Default(SplitsbyError.none()) SplitsbyError error,
    @Default(FriendStatus.notFriends) FriendStatus status,
    @Default([]) List<Group> groupsInCommon,
  }) = _InspectProfileState;
}