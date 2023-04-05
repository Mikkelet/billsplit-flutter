import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/extentions.dart';
import 'package:billsplit_flutter/presentation/group/bloc/group_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupBloc extends Cubit<GroupState> {
  late final Group _group;
  final List<Event> _events = [
    ...[0, 1, 2, 3, 5].mapToImmutableList((e) => GroupExpense.dummy(e))
  ];
  int _navIndex = 0;

  GroupBloc() : super(Loading());

  void loadGroup(String groupId) async {
    emit(Loading());
    await Future.delayed(const Duration(seconds: 2));
    _group = Group(
      id: groupId,
      name: "GroupName",
      people: [],
      createdBy: Person.dummy(0),
      timestamp: 0,
      debts: [],
      latestEvent: null
    );
    emit(GroupLoaded(_group, _events, 0));
  }

  void showPage(int index){
    _navIndex = index;
    final newState = GroupLoaded(_group, _events, _navIndex);
    emit(newState);
  }
}
