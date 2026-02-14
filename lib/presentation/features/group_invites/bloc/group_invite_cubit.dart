import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/group_invite.dart';
import 'package:billsplit_flutter/domain/use_cases/group_invites/observe_group_invites_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/group_invites/respond_to_group_invitation_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/base/bloc/safe_cubit.dart';
import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:billsplit_flutter/presentation/features/group_invites/bloc/group_invite_state.dart';

class GroupInvitesCubit extends SafeCubit<GroupInviteState> {
  final _observeGroupsUseCase = ObserveGroupInvitesUseCase();
  final _respondToGroupInviteUseCase = RespondToGroupInvitationUseCase();

  GroupInvitesCubit() : super(const GroupInviteState());

  Stream<Iterable<GroupInvite>> groupsStream() => _observeGroupsUseCase.observe();

  Future<bool> respond(Group group, bool accept) async {
    try {
      safeEmit(state.copyWith(isLoading: true));
      await _respondToGroupInviteUseCase.launch(group, accept);
      return true;
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.serverError(e.toString())));
      return false;
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }
}
