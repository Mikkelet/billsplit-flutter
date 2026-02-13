import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../_generated/presentation/features/profile/bloc/profile_state.freezed.dart';

enum ProfileStateEvents { none, showDeleteUser }

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(false) bool isLoading,
    @Default(0) int friendInvites,
    @Default(0) int groupInvites,
    @Default("") String version,
    @Default(ProfileStateEvents.none) ProfileStateEvents event,
  }) = _ProfileState;
}
