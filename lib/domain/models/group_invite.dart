import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/sync_state.dart';


class GroupInvite {
  final Group group;
  final SyncState syncState;

  GroupInvite({required this.group, required this.syncState});
}