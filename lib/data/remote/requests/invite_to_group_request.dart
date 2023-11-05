import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invite_to_group_request.g.dart';

@JsonSerializable(createFactory: false)
class InviteToGroupRequest {
    final String groupId;
    final String userId;

  InviteToGroupRequest({required this.groupId, required this.userId});

  Json toJson() => _$InviteToGroupRequestToJson(this);
}