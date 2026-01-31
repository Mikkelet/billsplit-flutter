import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/mappers/groups_mapper.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/repositories/auth_repository.dart';

class RespondToGroupInvitationUseCase {
  final _apiService = getIt<ApiService>();
  final _database = getIt<SplitsbyDatabase>();
  final _authRepository = getIt<AuthRepository>();

  Future<void> launch(Group group, bool accept) async {
    await _database.groupInvitesDAO.updatePending(group.toDb());
    await _apiService.respondToGroupInvite(group.id, accept);
    await _database.groupInvitesDAO.remove(group.toDb());
    group.respondToInvite(_authRepository.loggedInUser, accept);
    if (accept) {
      await _database.groupsDAO.insertGroup(group.toDb());
    }
  }
}
