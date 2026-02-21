// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/remote/requests/get_groups_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetGroupsResponse _$GetGroupsResponseFromJson(Map json) => GetGroupsResponse(
  (json['groups'] as List<dynamic>).map(
    (e) => GroupDTO.fromJson(Map<String, dynamic>.from(e as Map)),
  ),
);
