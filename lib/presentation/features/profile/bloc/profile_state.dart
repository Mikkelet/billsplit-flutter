import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../_generated/presentation/features/profile/bloc/profile_state.freezed.dart';

enum ProfileStateEvents {
  profilePictureUploading,
  updateDisplayNameLoading,
  displayNameUpdated,
  showDeleteUser,
  submittingEditName,
  none
}

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(false) bool isLoading,
    @Default(ProfileStateEvents.none) ProfileStateEvents event,
  }) = _ProfileState;
}
