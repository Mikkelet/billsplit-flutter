import 'package:billsplit_flutter/data/remote/dtos/event_dto.dart';
import 'package:billsplit_flutter/data/remote/dtos/person_dto.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part '../../../generated/remote/dtos/group_dto.g.dart';

@JsonSerializable()
class GroupDTO {
  final String id;
  final String name;
  final String coverImageUrl;
  final Iterable<PersonDTO> people;
  final Iterable<PersonDTO> pastMembers;
  final Iterable<PersonDTO>? invites;
  final PersonDTO createdBy;
  final num timestamp;
  final int lastUpdated;
  final String defaultCurrency;

  GroupDTO({
    required this.id,
    required this.name,
    required this.coverImageUrl,
    required this.defaultCurrency,
    required this.people,
    required this.pastMembers,
    required this.invites,
    required this.createdBy,
    required this.timestamp,
    required this.lastUpdated,
  });

  factory GroupDTO.fromJson(Json json) => _$GroupDTOFromJson(json);

  Json toJson() => _$GroupDTOToJson(this);

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is! GroupDTO) return false;
    return other.id == id;
  }
}
