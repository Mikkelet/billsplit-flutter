import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../_generated/presentation/features/update_phone_number/bloc/update_phone_number_state.freezed.dart';

class PhoneNumberLoaded extends Main {}

class UpdateStep extends Main {
  final int step;

  UpdateStep({required this.step});
}

class UpdateNumberSuccess extends Main {}

@freezed
abstract class UpdatePhoneNumberState with _$UpdatePhoneNumberState {
  const factory UpdatePhoneNumberState({
    @Default(false) bool isLoading,
    @Default("") String errorMessage,
    @Default("") String phoneNumber,
    @Default("") String countryCode,
  }) = _UpdatePhoneNumberState;
}
