import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/domain/mappers/groups_mapper.dart';
import 'package:billsplit_flutter/domain/models/group.dart';

class GetGroupsUseCase {
  final _apiService = ApiService();

  Future<List<Group>> launch() async {
    final response = await _apiService.getGroups();
    return response.groups.toGroups();
  }
}
