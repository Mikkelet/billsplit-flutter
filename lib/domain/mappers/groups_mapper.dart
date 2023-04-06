import 'package:billsplit_flutter/data/remote/dtos/group_dto.dart';
import 'package:billsplit_flutter/domain/mappers/debts_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/person_mapper.dart';
import 'package:billsplit_flutter/domain/models/group.dart';

extension GroupsExt on List<GroupDTO> {
  List<Group> toGroups() {
    return map((e) => e.toGroup()).toList();
  }
}

extension GroupExt on GroupDTO {
  Group toGroup() => Group(
      id: id,
      name: name,
      people: people.toPeople(),
      createdBy: createdBy.toPerson(),
      timestamp: timeStamp,
      latestEvent: null,
      debts: debts.toDebts());
}
