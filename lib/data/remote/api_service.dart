
import 'package:billsplit_flutter/data/remote/dtos/event_dto.dart';
import 'package:billsplit_flutter/data/remote/network_client.dart';
import 'package:billsplit_flutter/data/remote/requests/add_event_request.dart';
import 'package:billsplit_flutter/data/remote/requests/get_group_request.dart';
import 'package:billsplit_flutter/data/remote/requests/get_groups_request.dart';

import 'dtos/debts_dto.dart';

class ApiService {
  final _client = NetworkClient();

  Future<GetGroupsResponse> getGroups() async {
    final body = await _client.get("groups");
    return GetGroupsResponse.fromJson(body);
  }

  Future<GetGroupResponse> getGroup(String groupId) async {
    final body = await _client.get("group/$groupId");
    return GetGroupResponse.fromJson(body);
  }

  void onDestroy() {
    _client.onDestroy();
  }

  Future<AddEventResponse> addEvent(String groupId, EventDTO eventDTO, List<DebtDTO> debts) async {
    final request = AddEventRequest(groupId, eventDTO, debts);
    final response = await _client.post("event", request.toJson());
    return AddEventResponse.fromJson(response);
  }
}
