import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part '../../../generated/remote/requests/respond_to_group_invite_request.g.dart';

@JsonSerializable(createFactory: false)
class RespondToGroupInviteRequest {
  final String groupId;
  final bool accept;

  RespondToGroupInviteRequest(this.groupId, this.accept);

  Json toJson() => _$RespondToGroupInviteRequestToJson(this);
}