// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/remote/requests/add_friend_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$AddFriendRequestToJson(AddFriendRequest instance) =>
    <String, dynamic>{
      'type': instance.type.toJson(),
    };

AddFriendResponse _$AddFriendResponseFromJson(Map<String, dynamic> json) =>
    AddFriendResponse(
      FriendDTO.fromJson(json['friend'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RequestTypeEmailToJson(RequestTypeEmail instance) =>
    <String, dynamic>{
      'type': instance.type,
      'email': instance.email,
    };

Map<String, dynamic> _$RequestTypeUserIdToJson(RequestTypeUserId instance) =>
    <String, dynamic>{
      'type': instance.type,
      'friendId': instance.friendId,
    };

Map<String, dynamic> _$RequestTypePhoneToJson(RequestTypePhone instance) =>
    <String, dynamic>{
      'type': instance.type,
      'phoneNumber': instance.phoneNumber,
    };
