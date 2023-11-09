// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/remote/dtos/friend_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendDTO _$FriendDTOFromJson(Map<String, dynamic> json) => FriendDTO(
      json['createdBy'] as String,
      json['status'] as String,
      PersonDTO.fromJson(json['friend'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FriendDTOToJson(FriendDTO instance) => <String, dynamic>{
      'createdBy': instance.createdBy,
      'status': instance.status,
      'friend': instance.friend.toJson(),
    };
