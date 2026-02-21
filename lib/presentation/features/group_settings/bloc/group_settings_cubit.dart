import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/use_cases/groups/add_group_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/groups/add_person_to_group_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/groups/leave_group_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/groups/upload_group_picture_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/safe_cubit.dart';
import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:billsplit_flutter/presentation/features/group_settings/bloc/group_settings_state.dart';

class GroupSettingsCubit extends SafeCubit<GroupSettingsState> {
  final _leaveGroupUseCase = LeaveGroupUseCase();
  final _invitePersonToGroupUseCase = InvitePersonToGroupUseCase();
  final _addGroupUseCase = AddGroupUseCase();
  final _uploadGroupPicture = UploadGroupPictureUseCase();

  final Group group;

  GroupSettingsCubit(this.group) : super(const GroupSettingsState());

  Future<bool> leaveGroup() async {
    try {
      safeEmit(state.copyWith(leavingGroupIsLoading: true));
      await _leaveGroupUseCase.launch(group.id);
      return true;
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.serverError(e.toString())));
    } finally {
      safeEmit(state.copyWith(leavingGroupIsLoading: false));
    }
    return false;
  }

  Future<void> updateCurrency(Currency currency) async {
    try {
      safeEmit(state.copyWith(updatingCurrencyIsLoading: true));
      final copy = group.copyWith(defaultCurrency: currency.symbol);
      await _addGroupUseCase.launch(copy);
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.serverError(e.toString())));
    } finally {
      safeEmit(state.copyWith(updatingCurrencyIsLoading: false));
    }
  }

  Future updateGroupName(String newName) async {
    try {
      safeEmit(state.copyWith(updatingNameIsLoading: true));
      final copy = group.copyWith(name: newName);
      await _addGroupUseCase.launch(copy);
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.serverError(e.toString())));
    } finally {
      safeEmit(state.copyWith(updatingNameIsLoading: false));
    }
  }

  Future<void> uploadGroupPicture() async {
    try {
      safeEmit(state.copyWith(pictureUploadIsLoading: true));
      await _uploadGroupPicture.launch(group);
    } catch (e, st) {
      logError(e, st);
      if (e is UserCancelled) {
        safeEmit(state.copyWith(error: SplitsbyError.serverError("User cancelled upload")));
      } else {
        safeEmit(state.copyWith(error: SplitsbyError.serverError(e.toString())));
      }
    } finally {
      safeEmit(state.copyWith(pictureUploadIsLoading: false));
    }
  }

  void deleteGroupPicture() {}

  Future<void> invitePersonToGroup(Person person) async {
    try {
      safeEmit(state.copyWith(addingToGroupIsLoading: true));
      await _invitePersonToGroupUseCase.launch(group, person);
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.serverError(e.toString())));
    } finally {
      safeEmit(state.copyWith(addingToGroupIsLoading: false));
    }
  }
}
