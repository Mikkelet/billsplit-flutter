import 'package:billsplit_flutter/domain/models/subscription_service.dart';
import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/models/group.dart';

part '../../../../_generated/presentation/features/add_service/bloc/add_service_state.freezed.dart';

@freezed
abstract class AddServiceState with _$AddServiceState {
  const factory AddServiceState({
    @Default(SplitsbyError.none()) SplitsbyError error,
    @Default("") String serviceId,
    @Default(false) bool showCannotBe0ZeroError,
    @Default("") String nameErrorText,
    Group? group,
    SubscriptionService? service,
  }) = _AddServiceState;

  const AddServiceState._();

  bool get isLoading => group == null || service == null;

  Group get requireGroup => group!;

  SubscriptionService get requireService => service!;
}
