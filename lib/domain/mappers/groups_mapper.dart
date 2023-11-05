import 'dart:convert';

import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/dtos/group_dto.dart';
import 'package:billsplit_flutter/domain/mappers/event_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/person_mapper.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/group_invite.dart';
import 'package:billsplit_flutter/domain/models/sync_state.dart';
import 'package:billsplit_flutter/utils/utils.dart';

extension GroupDtosExt on Iterable<GroupDTO> {
  Iterable<Group> toGroups() {
    return map((e) => e.toGroup()).toList();
  }

  Iterable<GroupDb> toDb() => map((e) => e.toDb());

  Iterable<GroupInviteDb> toGroupInviteDb() => map((e) => e.toGroupInviteDb());
}

extension GroupDtoExt on GroupDTO {
  Group toGroup() => Group(
      id: id,
      name: name,
      coverImageUrl: coverImageUrl,
      defaultCurrency: defaultCurrency,
      lastUpdated: lastUpdated,
      people: people.toPeople(),
      invites: invites?.toPeople() ?? [],
      createdBy: createdBy.toPerson(),
      pastMembers: pastMembers.toPeople(),
      timestamp: timestamp,
      latestEvent: latestEvent.toEvent());

  GroupDb toDb() => GroupDb(
        groupId: id,
        group: json.encode(toJson()),
        lastUpdated: nowEpoch,
      );

  GroupInvite toGroupInvite() =>
      GroupInvite(group: toGroup(), syncState: SyncState.synced);

  GroupInviteDb toGroupInviteDb() => GroupInviteDb(
      groupId: id,
      syncState: SyncState.synced.index,
      group: json.encode(toJson()));
}

extension GroupExt on Group {
  GroupDTO toDTO() => GroupDTO(
      id: id,
      name: nameState,
      coverImageUrl: coverImageUrlState,
      people: people.toDTO(),
      invites: invites.toDTO(),
      lastUpdated: lastUpdatedState,
      defaultCurrency: defaultCurrencyState,
      pastMembers: pastMembers.toDTO(),
      createdBy: createdBy.toDTO(),
      timestamp: timestamp,
      latestEvent: latestEventState?.toEventDTO());

  GroupDb toDb() => toDTO().toDb();
}

extension GroupDbsExt on Iterable<GroupDb> {
  Iterable<Group> toGroups() => map((e) => e.toGroup());

  Iterable<GroupDTO> toDTOs() => map((e) => e.toDTO());
}

extension GroupDbExt on GroupDb {
  Group toGroup() {
    return toDTO().toGroup();
  }

  GroupDTO toDTO() {
    return GroupDTO.fromJson(json.decode(group));
  }
}
