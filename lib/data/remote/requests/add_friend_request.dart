import 'package:billsplit_flutter/data/remote/dtos/friend_dto.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part '../../../generated/remote/requests/add_friend_request.g.dart';

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
    } else if (this is RequestTypeUserId) {
      return (this as RequestTypeUserId).toJson();
    } else if (this is RequestTypePhone) {
      return (this as RequestTypePhone).toJson();
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
  final String friendId;

  RequestTypeUserId(this.friendId) : super("userId");

  @override
  Json toJson() => _$RequestTypeUserIdToJson(this);
}

@JsonSerializable(createFactory: false)
class RequestTypePhone extends FriendRequestType {
  final String phoneNumber;

  RequestTypePhone(this.phoneNumber) : super("phone");

  @override
  Json toJson() => _$RequestTypePhoneToJson(this);
}
