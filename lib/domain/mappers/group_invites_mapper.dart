import 'dart:convert';

import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/dtos/group_dto.dart';
import 'package:billsplit_flutter/domain/mappers/groups_mapper.dart';
import 'package:billsplit_flutter/domain/models/group_invite.dart';
import 'package:billsplit_flutter/domain/models/sync_state.dart';

extension GroupInvitesDbExt on GroupInviteDb {
  GroupInvite toGroupInvite() {
    final dto = GroupDTO.fromJson(jsonDecode(group));
    return GroupInvite(
      group: dto.toGroup(),
      syncState: SyncState.fromId(syncState),
    );
  }
}
