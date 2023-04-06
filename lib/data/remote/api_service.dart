
import 'package:billsplit_flutter/data/remote/network_client.dart';
import 'dtos/group_dto.dart';

class ApiService {
  final _client = NetworkClient();

  Future<List<GroupDTO>> getGroups() async {
    final body = await _client.get("groups");
    final groups = (body["groups"] as List)
        .map((e) => GroupDTO.fromJson(e))
        .toList();
    return groups;
  }

  void onDestroy() {
    _client.onDestroy();
  }
}
