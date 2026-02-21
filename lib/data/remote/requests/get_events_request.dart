import 'package:billsplit_flutter/data/remote/dtos/event_dto.dart';
import 'package:billsplit_flutter/data/remote/dtos/service_dto.dart';
import 'package:billsplit_flutter/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part '../../../_generated/data/remote/requests/get_events_request.g.dart';

@JsonSerializable(createToJson: false)
class GetEventsResponse {
  final List<EventDTO> events;
  final List<ServiceDTO> services;

  const GetEventsResponse({required this.events, required this.services});

  factory GetEventsResponse.fromJson(Json json) =>
      _$GetEventsResponseFromJson(json);
}
