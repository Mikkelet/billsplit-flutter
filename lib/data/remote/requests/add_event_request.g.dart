// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_event_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$AddEventRequestToJson(AddEventRequest instance) =>
    <String, dynamic>{
      'groupId': instance.groupId,
      'event': instance.event.toJson(),
      'debts': instance.debts.map((e) => e.toJson()).toList(),
    };

AddEventResponse _$AddEventResponseFromJson(Map<String, dynamic> json) =>
    AddEventResponse(
      json['event'] == null
          ? null
          : EventDTO.fromJson(json['event'] as Map<String, dynamic>),
    );
