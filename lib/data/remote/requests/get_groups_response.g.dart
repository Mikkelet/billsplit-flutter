// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_groups_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetGroupsResponse _$GetGroupsResponseFromJson(Map<String, dynamic> json) =>
    GetGroupsResponse(
      (json['groups'] as List<dynamic>)
          .map((e) => GroupDTO.fromJson(e as Map<String, dynamic>)),
    );
