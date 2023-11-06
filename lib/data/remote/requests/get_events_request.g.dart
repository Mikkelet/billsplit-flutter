// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_events_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetEventsResponse _$GetEventsResponseFromJson(Map<String, dynamic> json) =>
    GetEventsResponse(
      events: (json['events'] as List<dynamic>).map((e) =>
          e == null ? null : EventDTO.fromJson(e as Map<String, dynamic>)),
      services: (json['services'] as List<dynamic>)
          .map((e) => ServiceDTO.fromJson(e as Map<String, dynamic>)),
    );
