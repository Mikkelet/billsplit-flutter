import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/groups_mapper.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';

class InviteToGroupUseCase {
  final _apiService = getIt<ApiService>();
  final _database = getIt<SplitsbyDatabase>();


  Future<void> launch(Group group, Person person) async {
    await _apiService.invitePersonToGroup(group.id, person.uid);
    group.invitesState.add(person);
    await _database.groupsDAO.insertGroup(group.toDb());
  }
}
