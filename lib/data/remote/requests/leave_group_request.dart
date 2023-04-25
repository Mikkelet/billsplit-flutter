import 'package:billsplit_flutter/data/remote/dtos/group_dto.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'leave_group_request.g.dart';

@JsonSerializable(createToJson: false)
class LeaveGroupRequest {
  final GroupDTO group;

  LeaveGroupRequest(this.group);

  factory LeaveGroupRequest.fromJson(Json json) =>
      _$LeaveGroupRequestFromJson(json);
}
