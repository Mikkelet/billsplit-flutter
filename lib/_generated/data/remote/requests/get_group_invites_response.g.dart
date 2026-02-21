// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/remote/requests/get_group_invites_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetGroupInvitesResponse _$GetGroupInvitesResponseFromJson(Map json) =>
    GetGroupInvitesResponse(
      (json['groups'] as List<dynamic>).map(
        (e) => GroupDTO.fromJson(Map<String, dynamic>.from(e as Map)),
      ),
    );
