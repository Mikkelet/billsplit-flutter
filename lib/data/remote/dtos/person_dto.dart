import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'person_dto.g.dart';

@JsonSerializable()
class PersonDTO {
  final String id;
  final String name;
  final String pfpUrl;

  PersonDTO(this.id, this.name, this.pfpUrl);

  factory PersonDTO.fromJson(Json json) => _$PersonDTOFromJson(json);

  Json toJson() => _$PersonDTOToJson(this);
}