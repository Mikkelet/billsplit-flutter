import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/group_invite.dart';
import 'package:billsplit_flutter/domain/use_cases/group_invites/observe_group_invites_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/group_invites/respond_to_group_invitation_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';

class GroupInvitesCubit extends BaseCubit {
  final _observeGroupsUseCase = ObserveGroupInvitesUseCase();
  final _respondToGroupInviteUseCase = RespondToGroupInvitationUseCase();

  Stream<Iterable<GroupInvite>> groupsStream() =>
      _observeGroupsUseCase.observe();

  void respond(Group group, bool accept) {
    showLoading();
    _respondToGroupInviteUseCase.launch(group, accept).then((value) {
      update();
    }).catchError((err, stackTrace) {
      showError(err, stackTrace);
    });
  }
}
