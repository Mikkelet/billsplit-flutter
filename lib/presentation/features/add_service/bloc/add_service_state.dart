import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../_generated/presentation/features/add_service/bloc/add_service_state.freezed.dart';

@freezed
abstract class AddServiceState with _$AddServiceState {
  const factory AddServiceState({
    @Default(false) bool isLoading,
    @Default(SplitsbyError.none()) SplitsbyError error,
    @Default(false) bool showCannotBe0ZeroError,
    @Default("") String nameErrorText,
  }) = _AddServiceState;
}
