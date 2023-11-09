import 'package:billsplit_flutter/data/remote/dtos/group_dto.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part '../../../generated/remote/requests/get_groups_response.g.dart';

@JsonSerializable(createToJson: false)
class GetGroupsResponse {
  final Iterable<GroupDTO> groups;

  GetGroupsResponse(this.groups);

  factory GetGroupsResponse.fromJson(Json json) =>
      _$GetGroupsResponseFromJson(json);
}
