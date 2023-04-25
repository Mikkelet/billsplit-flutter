// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupDTO _$GroupDTOFromJson(Map<String, dynamic> json) => GroupDTO(
      id: json['id'] as String,
      name: json['name'] as String,
      people: (json['people'] as List<dynamic>)
          .map((e) => PersonDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      pastMembers: (json['pastMembers'] as List<dynamic>)
          .map((e) => PersonDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdBy: PersonDTO.fromJson(json['createdBy'] as Map<String, dynamic>),
      timeStamp: json['timeStamp'] as num,
      debts: (json['debts'] as List<dynamic>)
          .map((e) => DebtDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      latestEvent: json['latestEvent'] == null
          ? null
          : EventDTO.fromJson(json['latestEvent'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GroupDTOToJson(GroupDTO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'people': instance.people.map((e) => e.toJson()).toList(),
      'pastMembers': instance.pastMembers.map((e) => e.toJson()).toList(),
      'createdBy': instance.createdBy.toJson(),
      'timeStamp': instance.timeStamp,
      'debts': instance.debts.map((e) => e.toJson()).toList(),
      'latestEvent': instance.latestEvent?.toJson(),
    };
