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

    if (accept) {
      final invitesCopy = List.of(group.invites);
      invitesCopy.remove(_authRepository.loggedInUser);
      final groupCopy = group.copyWith(invites: invitesCopy);
      await _database.groupsDAO.insertGroup(groupCopy.toDb());
    } else {
      final invitesCopy = List.of(group.invites);
      final peopleCopy = List.of(group.people);
      invitesCopy.remove(_authRepository.loggedInUser);
      peopleCopy.add(_authRepository.loggedInUser);
      final groupCopy = group.copyWith(invites: invitesCopy, people: peopleCopy);
      await _database.groupsDAO.insertGroup(groupCopy.toDb());
    }
  }
}