import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../_generated/presentation/features/update_phone_number/bloc/update_phone_number_state.freezed.dart';

@freezed
abstract class UpdatePhoneNumberState with _$UpdatePhoneNumberState {
  const factory UpdatePhoneNumberState({
    @Default(false) bool isLoading,
    @Default(SplitsbyError.none()) SplitsbyError errorMessage,
    @Default(false) bool success,
    @Default("") String phoneNumber,
    @Default("") String countryCode,
  }) = _UpdatePhoneNumberState;

  const UpdatePhoneNumberState._();

  UpdatePhoneNumberState loading() => copyWith(isLoading: true, errorMessage: SplitsbyError.none());
}
