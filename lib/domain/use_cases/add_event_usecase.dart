import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/domain/mappers/event_mapper.dart';
import 'package:billsplit_flutter/domain/models/event.dart';

class AddEventUseCase {
  final _apiService = ApiService();

  Future<Event?> launch(String groupId, Event event) async {
    final response =
        await _apiService.addEvent(groupId, event.toEventDTO(), []);
    return response.event.toEvent();
  }
}
