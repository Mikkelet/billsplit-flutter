// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/remote/requests/add_group_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$AddGroupRequestToJson(AddGroupRequest instance) =>
    <String, dynamic>{'group': instance.group.toJson()};

AddGroupResponse _$AddGroupResponseFromJson(Map json) => AddGroupResponse(
  GroupDTO.fromJson(Map<String, dynamic>.from(json['group'] as Map)),
);
