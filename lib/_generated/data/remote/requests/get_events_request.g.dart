// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/remote/requests/get_events_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetEventsResponse _$GetEventsResponseFromJson(Map json) => GetEventsResponse(
  events: (json['events'] as List<dynamic>)
      .map((e) => EventDTO.fromJson(Map<String, dynamic>.from(e as Map)))
      .toList(),
  services: (json['services'] as List<dynamic>)
      .map((e) => ServiceDTO.fromJson(Map<String, dynamic>.from(e as Map)))
      .toList(),
);
