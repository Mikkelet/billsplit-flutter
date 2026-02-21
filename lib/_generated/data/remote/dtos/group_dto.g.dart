// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/remote/dtos/group_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupDTO _$GroupDTOFromJson(Map json) => GroupDTO(
  id: json['id'] as String,
  name: json['name'] as String,
  coverImageUrl: json['coverImageUrl'] as String,
  defaultCurrency: json['defaultCurrency'] as String,
  people: (json['people'] as List<dynamic>).map(
    (e) => PersonDTO.fromJson(Map<String, dynamic>.from(e as Map)),
  ),
  pastMembers: (json['pastMembers'] as List<dynamic>).map(
    (e) => PersonDTO.fromJson(Map<String, dynamic>.from(e as Map)),
  ),
  invites: (json['invites'] as List<dynamic>).map(
    (e) => PersonDTO.fromJson(Map<String, dynamic>.from(e as Map)),
  ),
  createdBy: PersonDTO.fromJson(
    Map<String, dynamic>.from(json['createdBy'] as Map),
  ),
  timestamp: json['timestamp'] as num,
  lastUpdated: (json['lastUpdated'] as num).toInt(),
);

Map<String, dynamic> _$GroupDTOToJson(GroupDTO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'coverImageUrl': instance.coverImageUrl,
  'people': instance.people.map((e) => e.toJson()).toList(),
  'pastMembers': instance.pastMembers.map((e) => e.toJson()).toList(),
  'invites': instance.invites.map((e) => e.toJson()).toList(),
  'createdBy': instance.createdBy.toJson(),
  'timestamp': instance.timestamp,
  'lastUpdated': instance.lastUpdated,
  'defaultCurrency': instance.defaultCurrency,
};
