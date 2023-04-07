
import 'package:billsplit_flutter/data/remote/network_client.dart';
import 'package:billsplit_flutter/data/remote/requests/get_group_request.dart';
import 'package:billsplit_flutter/data/remote/requests/get_groups_request.dart';

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
}
