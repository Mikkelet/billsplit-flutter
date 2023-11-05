// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_group_invites_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetGroupInvitesResponse _$GetGroupInvitesResponseFromJson(
        Map<String, dynamic> json) =>
    GetGroupInvitesResponse(
      (json['groups'] as List<dynamic>)
          .map((e) => GroupDTO.fromJson(e as Map<String, dynamic>)),
    );
