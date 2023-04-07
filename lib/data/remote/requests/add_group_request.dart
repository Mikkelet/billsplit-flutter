import 'package:billsplit_flutter/data/remote/dtos/group_dto.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_group_request.g.dart';

@JsonSerializable(createFactory: false)
class AddGroupRequest {
  final GroupDTO group;

  AddGroupRequest(this.group);

  Json toJson() => _$AddGroupRequestToJson(this);
}

@JsonSerializable(createToJson: false)
class AddGroupResponse {
  final GroupDTO group;

  AddGroupResponse(this.group);

  factory AddGroupResponse.fromJson(Json json) => _$AddGroupResponseFromJson(json);
}