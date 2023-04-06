// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupDTO _$GroupDTOFromJson(Map<String, dynamic> json) => GroupDTO(
      json['id'] as String,
      json['name'] as String,
      (json['people'] as List<dynamic>)
          .map((e) => PersonDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      PersonDTO.fromJson(json['createdBy'] as Map<String, dynamic>),
      json['timeStamp'] as num,
      (json['debts'] as List<dynamic>)
          .map((e) => DebtDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GroupDTOToJson(GroupDTO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'people': instance.people,
      'createdBy': instance.createdBy,
      'timeStamp': instance.timeStamp,
      'debts': instance.debts,
    };
