import 'package:billsplit_flutter/data/remote/dtos/friend_dto.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_friend_request.g.dart';

@JsonSerializable(createFactory: false)
class AddFriendRequest {
  final FriendRequestType type;

  AddFriendRequest(this.type);

  Json toJson() => _$AddFriendRequestToJson(this);
}

@JsonSerializable(createToJson: false)
class AddFriendResponse {
  final FriendDTO friend;

  AddFriendResponse(this.friend);

  factory AddFriendResponse.fromJson(Json json) =>
      _$AddFriendResponseFromJson(json);
}

@JsonSerializable(createFactory: false, createToJson: false)
class FriendRequestType {
  final String type;

  FriendRequestType(this.type);

  Json toJson() {
    if (this is RequestTypeEmail) {
      return (this as RequestTypeEmail).toJson();
    }
    if (this is RequestTypeUserId) {
      return (this as RequestTypeUserId).toJson();
    } else {
      throw Error();
    }
  }
}

@JsonSerializable(createFactory: false)
class RequestTypeEmail extends FriendRequestType {
  final String email;

  RequestTypeEmail(this.email) : super('email');

  @override
  Json toJson() => _$RequestTypeEmailToJson(this);
}

@JsonSerializable(createFactory: false)
class RequestTypeUserId extends FriendRequestType {
  final String userId;

  RequestTypeUserId(this.userId) : super("userId");

  @override
  Json toJson() => _$RequestTypeUserIdToJson(this);
}
