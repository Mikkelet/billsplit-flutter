import 'package:billsplit_flutter/domain/models/app_version.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/notification_action.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';

import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../_generated/presentation/main_state.freezed.dart';

@freezed
abstract class MainState with _$MainState {
  const factory MainState({
    @Default(false) bool isLoading,
    @Default(SplitsbyError.none()) SplitsbyError error,
  }) = _MainState;
}