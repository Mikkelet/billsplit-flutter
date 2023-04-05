import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/extentions.dart';
import 'package:billsplit_flutter/presentation/group/bloc/group_event.dart';
import 'package:billsplit_flutter/presentation/group/bloc/group_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  late final Group _group;
  final List<Event> _events = [
    ...[0, 1, 2, 3, 5].mapToImmutableList((e) => GroupExpense.dummy(e))
  ];
  int _navIndex = 0;

  GroupBloc() : super(Loading()) {
    on<LoadGroup>(_loadGroup);
    on<NavigateTo>(_navigateTo);
  }

  void _loadGroup(LoadGroup event, Emitter<GroupState> emit) async {
    emit(Loading());
    await Future.delayed(const Duration(seconds: 2));
    _group = Group.mock(0);
    emit(GroupLoaded(_group, _events, _navIndex));
  }

  void _navigateTo(NavigateTo event, Emitter<GroupState> emit) async {
    _navIndex = event.index;
    emit(GroupLoaded(_group, _events, _navIndex));
  }
}
