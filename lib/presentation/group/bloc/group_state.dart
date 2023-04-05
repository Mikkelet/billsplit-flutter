import 'package:billsplit_flutter/domain/models/event.dart';
import 'package:billsplit_flutter/domain/models/group.dart';

abstract class GroupState {}

class GroupLoaded extends GroupState {
  final Group group;
  final List<Event> events;
  final int navIndex;
  GroupLoaded(this.group, this.events, this.navIndex);
}
class Loading extends GroupState {}


