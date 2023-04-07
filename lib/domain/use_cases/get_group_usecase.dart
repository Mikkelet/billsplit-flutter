import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/domain/mappers/event_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/groups_mapper.dart';
import 'package:billsplit_flutter/domain/mappers/service_mapper.dart';

class GetGroupUseCase {
  final _apiService = ApiService();

  Future<Map<String, dynamic>> launch(String groupId) async {
    final response = await _apiService.getGroup(groupId);
    print(response.group);
    print(response.events);
    print(response.services);
    return {
      "group": response.group.toGroup(),
      "events": response.events.toEvents(),
      "services": response.services.toServices()
    };
  }
}
