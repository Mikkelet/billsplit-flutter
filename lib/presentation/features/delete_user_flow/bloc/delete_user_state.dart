import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../_generated/presentation/features/delete_user_flow/bloc/delete_user_state.freezed.dart';

@freezed
abstract class DeleteUserState with _$DeleteUserState {
  const factory DeleteUserState({
    @Default(false) bool isLoading,
    @Default(SplitsbyError.none()) SplitsbyError error,
  }) = _DeleteUserState;
}