// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/remote/requests/add_event_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$AddEventRequestToJson(AddEventRequest instance) => <String, dynamic>{
  'groupId': instance.groupId,
  'event': instance.event.toJson(),
};

AddEventResponse _$AddEventResponseFromJson(Map json) =>
    AddEventResponse(EventDTO.fromJson(json['event'] as Map<String, dynamic>));
