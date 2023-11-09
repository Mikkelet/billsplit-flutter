import 'package:billsplit_flutter/data/remote/dtos/group_dto.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part '../../../generated/remote/requests/get_group_request.g.dart';

@JsonSerializable(createToJson: false)
class GetGroupResponse {
  final GroupDTO group;

  GetGroupResponse(this.group);

  factory GetGroupResponse.fromJson(Json json) =>
      _$GetGroupResponseFromJson(json);
}