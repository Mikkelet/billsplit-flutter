import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';

class GroupsLoadedState extends Main {
  final List<Group> groups;

  GroupsLoadedState(this.groups);
}