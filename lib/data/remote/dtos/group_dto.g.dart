// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupDTO _$GroupDTOFromJson(Map<String, dynamic> json) => GroupDTO(
      id: json['id'] as String,
      name: json['name'] as String,
      coverImageUrl: json['coverImageUrl'] as String,
      defaultCurrency: json['defaultCurrency'] as String,
      people: (json['people'] as List<dynamic>)
          .map((e) => PersonDTO.fromJson(e as Map<String, dynamic>)),
      pastMembers: (json['pastMembers'] as List<dynamic>)
          .map((e) => PersonDTO.fromJson(e as Map<String, dynamic>)),
      invites: (json['invites'] as List<dynamic>?)
          ?.map((e) => PersonDTO.fromJson(e as Map<String, dynamic>)),
      createdBy: PersonDTO.fromJson(json['createdBy'] as Map<String, dynamic>),
      timestamp: json['timestamp'] as num,
      lastUpdated: json['lastUpdated'] as num,
      latestEvent: json['latestEvent'] == null
          ? null
          : EventDTO.fromJson(json['latestEvent'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GroupDTOToJson(GroupDTO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'coverImageUrl': instance.coverImageUrl,
      'people': instance.people.map((e) => e.toJson()).toList(),
      'pastMembers': instance.pastMembers.map((e) => e.toJson()).toList(),
      'invites': instance.invites?.map((e) => e.toJson()).toList(),
      'createdBy': instance.createdBy.toJson(),
      'timestamp': instance.timestamp,
      'latestEvent': instance.latestEvent?.toJson(),
      'lastUpdated': instance.lastUpdated,
      'defaultCurrency': instance.defaultCurrency,
    };
