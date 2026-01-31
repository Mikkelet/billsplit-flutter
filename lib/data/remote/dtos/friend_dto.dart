import 'package:billsplit_flutter/data/remote/dtos/person_dto.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part '../../../generated/remote/dtos/friend_dto.g.dart';

@JsonSerializable()
class FriendDTO {
  final String createdBy;
  final String  status;
  final PersonDTO friend;

  FriendDTO(this.createdBy, this.status, this.friend);

  factory FriendDTO.fromJson(Json json) => _$FriendDTOFromJson(json);

  Json toJson() => _$FriendDTOToJson(this);


  static const statusAccepted = "accepted";
  static const statusPending = "pending";
}