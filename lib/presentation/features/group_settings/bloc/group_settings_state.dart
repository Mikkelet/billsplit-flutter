import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../_generated/presentation/features/group_settings/bloc/group_settings_state.freezed.dart';

@freezed
abstract class GroupSettingsState with _$GroupSettingsState {
  const factory GroupSettingsState({
    @Default(false) bool leavingGroupIsLoading,
    @Default(false) bool updatingCurrencyIsLoading,
    @Default(false) bool addingToGroupIsLoading,
    @Default(false) bool pictureUploadIsLoading,
    @Default(false) bool updatingNameIsLoading,
    @Default(SplitsbyError.none()) SplitsbyError error,
    @Default(EditGroupNameState.display) EditGroupNameState displayState,
  }) = _GroupSettingsState;
}

enum EditGroupNameState {
  display,
  isEditing,
  isUpdating,
}
