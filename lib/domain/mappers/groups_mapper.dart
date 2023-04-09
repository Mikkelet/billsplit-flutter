import 'dart:convert';

import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/dtos/group_dto.dart';
import 'package:billsplit_flutter/domain/mappers/debts_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/event_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/person_mapper.dart';
import 'package:billsplit_flutter/domain/models/group.dart';

extension GroupDtosExt on List<GroupDTO> {
  List<Group> toGroups() {
    return map((e) => e.toGroup()).toList();
  }

  List<GroupDb> toDb() => map((e) => e.toDb()).toList();
}

extension GroupDtoExt on GroupDTO {
  Group toGroup() =>
      Group(
          id: id,
          name: name,
          people: people.toPeople(),
          createdBy: createdBy.toPerson(),
          timestamp: timeStamp,
          latestEvent: null,
          debts: debts.toDebts());

  GroupDb toDb() => GroupDb(groupId: id, group: json.encode(this));
}

extension GroupExt on Group {
  GroupDTO toDTO() =>
      GroupDTO(
          id: id,
          name: name,
          people: people.toDTO(),
          createdBy: createdBy.toDTO(),
          timeStamp: timestamp,
          debts: debts.map((e) => e.toDTO()).toList(),
          latestEvent: latestEvent?.toEventDTO());

  GroupDb toDb() => toDTO().toDb();
}

extension GroupDbsExt on List<GroupDb> {
  List<Group> toGroups() => map((e) => e.toGroup()).toList();
}

extension GroupDbExt on GroupDb {
  Group toGroup() {
    final dto = GroupDTO.fromJson(json.decode(group));
    return dto.toGroup();
  }
}
