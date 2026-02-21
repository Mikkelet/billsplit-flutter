import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../_generated/presentation/features/landing/bloc/landing_state.freezed.dart';

@freezed
abstract class LandingState with _$LandingState {
  const factory LandingState({
    @Default(false) bool isLoading,
    @Default(SplitsbyError.none()) SplitsbyError error,
    @Default("") String emailError,
    @Default("") String passwordError,
    @Default("") String repeatPasswordError,
  }) = _LandingState;

  const LandingState._();

  LandingState loading() => copyWith(isLoading: true, error: SplitsbyError.none());
}
