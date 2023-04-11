// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_group_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$AddGroupRequestToJson(AddGroupRequest instance) =>
    <String, dynamic>{
      'group': instance.group.toJson(),
    };

AddGroupResponse _$AddGroupResponseFromJson(Map<String, dynamic> json) =>
    AddGroupResponse(
      GroupDTO.fromJson(json['group'] as Map<String, dynamic>),
    );
