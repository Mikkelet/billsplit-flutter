import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../_generated/presentation/features/groups/bloc/groups_state.freezed.dart';

@freezed
abstract class GroupsState with _$GroupsState {
  const factory GroupsState({
    @Default(false) bool isLoading,
    @Default(SplitsbyError.none()) SplitsbyError error,
    @Default([]) List<Group> groups,
    @Default(0) int notifications,
  }) = _GroupsState;
}
