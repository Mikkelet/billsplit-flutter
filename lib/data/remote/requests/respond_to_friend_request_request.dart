import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'respond_to_friend_request_request.g.dart';

@JsonSerializable(createFactory: false)
class RespondToFriendRequestRequest {
  final bool accept;
  final String friendUid;
  final String requestId;

  RespondToFriendRequestRequest(
      {required this.accept, required this.friendUid, required this.requestId});

  Json toJson() => _$RespondToFriendRequestRequestToJson(this);
}
