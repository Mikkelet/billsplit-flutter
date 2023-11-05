import 'package:billsplit_flutter/data/remote/dtos/group_dto.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_group_invites_response.g.dart';

@JsonSerializable(createToJson: false)
class GetGroupInvitesResponse {
  final Iterable<GroupDTO> groups;

  GetGroupInvitesResponse(this.groups);

  factory GetGroupInvitesResponse.fromJson(Json json) =>
      _$GetGroupInvitesResponseFromJson(json);
}