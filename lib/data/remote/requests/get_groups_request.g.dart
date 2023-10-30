// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_groups_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetGroupsResponse _$GetGroupsResponseFromJson(Map<String, dynamic> json) =>
    GetGroupsResponse(
      (json['groups'] as List<dynamic>)
          .map((e) => GroupDTO.fromJson(e as Map<String, dynamic>)),
    );

Map<String, dynamic> _$GetGroupsResponseToJson(GetGroupsResponse instance) =>
    <String, dynamic>{
      'groups': instance.groups.map((e) => e.toJson()).toList(),
    };
