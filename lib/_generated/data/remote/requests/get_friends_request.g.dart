// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/remote/requests/get_friends_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFriendsResponse _$GetFriendsResponseFromJson(Map json) => GetFriendsResponse(
  (json['friends'] as List<dynamic>).map(
    (e) => FriendDTO.fromJson(Map<String, dynamic>.from(e as Map)),
  ),
);
