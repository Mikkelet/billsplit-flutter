import 'package:billsplit_flutter/data/remote/dtos/debts_dto.dart';
import 'package:billsplit_flutter/data/remote/dtos/event_dto.dart';
import 'package:billsplit_flutter/data/remote/dtos/person_dto.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group_dto.g.dart';

@JsonSerializable()
class GroupDTO {
  final String id;
  final String name;
  final List<PersonDTO> people;
  final PersonDTO createdBy;
  final num timeStamp;
  final List<DebtDTO> debts;
  final EventDTO? latestEvent;

  GroupDTO(this.id, this.name, this.people, this.createdBy, this.timeStamp,
      this.debts, this.latestEvent);

  factory GroupDTO.fromJson(Json json) => _$GroupDTOFromJson(json);

  Json toJson() => _$GroupDTOToJson(this);
}
