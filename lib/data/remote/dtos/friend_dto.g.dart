// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendDTO _$FriendDTOFromJson(Map<String, dynamic> json) => FriendDTO(
      json['id'] as String,
      json['createdBy'] as String,
      json['status'] as String,
      PersonDTO.fromJson(json['friend'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FriendDTOToJson(FriendDTO instance) => <String, dynamic>{
      'id': instance.id,
      'createdBy': instance.createdBy,
      'status': instance.status,
      'friend': instance.friend.toJson(),
    };
