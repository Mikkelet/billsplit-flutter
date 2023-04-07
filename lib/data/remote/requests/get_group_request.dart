import 'package:billsplit_flutter/data/remote/dtos/event_dto.dart';
import 'package:billsplit_flutter/data/remote/dtos/group_dto.dart';
import 'package:billsplit_flutter/data/remote/dtos/service_dto.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_group_request.g.dart';

class GetGroupRequest {
  final String groupId;

  GetGroupRequest(this.groupId);
}

@JsonSerializable()
class GetGroupResponse {
  final GroupDTO group;
  final List<EventDTO?> events;
  final List<ServiceDTO> services;

  GetGroupResponse(this.group, this.events, this.services);

  factory GetGroupResponse.fromJson(Json json) =>
      _$GetGroupResponseFromJson(json);

  Json toJson() => _$GetGroupResponseToJson(this);
}