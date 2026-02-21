import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../_generated/presentation/features/onboarding/bloc/onboarding_state.freezed.dart';

@freezed
abstract class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    @Default(false) bool isLoading,
    @Default(SplitsbyError.none()) SplitsbyError error,
    @Default(Currency.usdValue) Currency selectedCurrency,
    @Default("") String filePath,
  }) = _OnboardingState;

  const OnboardingState._();

  OnboardingState loading() => copyWith(isLoading: true, error: SplitsbyError.none());
}
