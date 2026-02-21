import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../_generated/presentation/common/update_textfield/update_textfield_state.freezed.dart';

enum UpdatableTextFieldView {
  display,
  edit;
}

@freezed
abstract class UpdatableTextFieldState with _$UpdatableTextFieldState {
  const factory UpdatableTextFieldState({
    @Default(false) bool isLoading,
    @Default(SplitsbyError.none()) SplitsbyError error,
    @Default(UpdatableTextFieldView.display) UpdatableTextFieldView view
  }) = _UpdatableTextFieldState;
}