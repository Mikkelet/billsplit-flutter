import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../_generated/presentation/features/splash/bloc/splash_state.freezed.dart';

@freezed
abstract class SplashState with _$SplashState {
  const factory SplashState({
    @Default(true) bool isLoading,
    @Default(SplitsbyError.none()) SplitsbyError error,
  }) = _SplashState;

  const SplashState._();
}
