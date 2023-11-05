import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/models/group.dart';

class RespondToGroupInvitationUseCase {
  final _apiService = getIt<ApiService>();

  Future<void> launch(Group group, bool accept) async {
    await _apiService.respondToGroupInvite(group.id, accept);
  }
}