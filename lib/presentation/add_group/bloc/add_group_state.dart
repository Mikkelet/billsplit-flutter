import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';

class GroupAdded extends Main {
  final Group group;

  GroupAdded(this.group);
}
