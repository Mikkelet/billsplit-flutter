import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part '../../../generated/remote/dtos/friend_status_dto.g.dart';

@JsonSerializable()
class FriendStatusDTO {
  final String type;

  FriendStatusDTO(this.type);

  FriendStatusDTO get typeClass {
    if (type == "accepted") return Accepted(type);
    return Pending(type);
  }

  factory FriendStatusDTO.fromJson(Json json) =>
      _$FriendStatusDTOFromJson(json);

  Json toJson() => _$FriendStatusDTOToJson(this);

}

class Accepted extends FriendStatusDTO {
  Accepted(super.type);
}

class Pending extends FriendStatusDTO {
  Pending(super.type);
}
