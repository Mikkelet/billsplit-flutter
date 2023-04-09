// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_friends_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFriendsResponse _$GetFriendsResponseFromJson(Map<String, dynamic> json) =>
    GetFriendsResponse(
      (json['friends'] as List<dynamic>)
          .map((e) => FriendDTO.fromJson(e as Map<String, dynamic>)),
    );
