// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_group_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetGroupResponse _$GetGroupResponseFromJson(Map<String, dynamic> json) =>
    GetGroupResponse(
      GroupDTO.fromJson(json['group'] as Map<String, dynamic>),
      (json['events'] as List<dynamic>)
          .map((e) =>
              e == null ? null : EventDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['services'] as List<dynamic>)
          .map((e) => ServiceDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetGroupResponseToJson(GetGroupResponse instance) =>
    <String, dynamic>{
      'group': instance.group.toJson(),
      'events': instance.events.map((e) => e?.toJson()).toList(),
      'services': instance.services.map((e) => e.toJson()).toList(),
    };
