import 'package:billsplit_flutter/data/remote/dtos/friend_status_dto.dart';
import 'package:billsplit_flutter/data/remote/dtos/person_dto.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'friend_dto.g.dart';

@JsonSerializable()
class FriendDTO {
  final String id;
  final String createdBy;
  final FriendStatusDTO status;
  final PersonDTO friend;

  FriendDTO(this.id, this.createdBy, this.status, this.friend);

  factory FriendDTO.fromJson(Json json) => _$FriendDTOFromJson(json);

  Json toJson() => _$FriendDTOToJson(this);
}