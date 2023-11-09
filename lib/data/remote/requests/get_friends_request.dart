import 'package:billsplit_flutter/data/remote/dtos/friend_dto.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part '../../../generated/remote/requests/get_friends_request.g.dart';

@JsonSerializable(createToJson: false)
class GetFriendsResponse {
  final Iterable<FriendDTO> friends;

  GetFriendsResponse(this.friends);

  factory GetFriendsResponse.fromJson(Json json) => _$GetFriendsResponseFromJson(json);
}
