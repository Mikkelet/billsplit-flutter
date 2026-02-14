import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../_generated/presentation/features/group_invites/bloc/group_invite_state.freezed.dart';

@freezed
abstract class GroupInviteState with _$GroupInviteState {
  const factory GroupInviteState({
    @Default(false) bool isLoading,
    @Default(SplitsbyError.none()) SplitsbyError error,
  }) = _GroupInviteState;
}