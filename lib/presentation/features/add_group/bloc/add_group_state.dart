import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/base/errors.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../_generated/presentation/features/add_group/bloc/add_group_state.freezed.dart';

@freezed
abstract class AddGroupState with _$AddGroupState {
  const factory AddGroupState({
    @Default(false) bool isLoading,
    @Default(SplitsbyError.none()) SplitsbyError error,
    @Default("") String groupName,
    @Default("") String currency,
    @Default([]) List<Person> people,
    @Default(false) bool isAdded,
  }) = _AddGroupState;
}