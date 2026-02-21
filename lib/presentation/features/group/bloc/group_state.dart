import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:billsplit_flutter/utils/pair.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/models/group.dart';
part '../../../../_generated/presentation/features/group/bloc/group_state.freezed.dart';

enum GroupPageNav {
  events,
  services,
  debt;

  static GroupPageNav fromIndex(int index) {
    switch (index) {
      case 2:
        return GroupPageNav.debt;
      case 1:
        return GroupPageNav.services;
      default:
        return GroupPageNav.events;
    }
  }
}

enum SortEvents {
  added,
  specified;
}

@freezed
abstract class GroupState with _$GroupState {
  const factory GroupState({
    @Default(false) bool isLoading,
    @Default(GroupPageNav.events) GroupPageNav groupNav,
    @Default(SortEvents.added) SortEvents sortBy,
    @Default([]) Iterable<Pair<Person, num>> debts,
    @Default(SplitsbyError.none()) SplitsbyError error,
    Group? group,
  }) = _GroupState;

  const GroupState._();

  Group get requireGroup => group!;
}
