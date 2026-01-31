import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/use_cases/groups/add_group_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/groups/add_person_to_group_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/groups/leave_group_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/groups/upload_group_picture_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/features/group_settings/bloc/group_settings_state.dart';

class GroupSettingsCubit extends BaseCubit {
  final _leaveGroupUseCase = LeaveGroupUseCase();
  final _invitePersonToGroupUseCase = InvitePersonToGroupUseCase();
  final _addGroupUseCase = AddGroupUseCase();
  final _uploadGroupPicture = UploadGroupPictureUseCase();

  final Group group;

  GroupSettingsCubit(this.group) : super();

  void leaveGroup() {
    showLoading();
    _leaveGroupUseCase.launch(group.id).then((value) {
      emit(GroupLeft());
    }).catchError((err, st) {
      showError(err, st);
    });
  }

  Future updateGroupName(String newName) async {
    group.nameState.value = newName;
    await _addGroupUseCase.launch(group);
  }

  void updateCurrency(Currency currency) {
    group.defaultCurrencyState.value = currency.symbol;
  }

  void uploadGroupPicture() {
    emit(GroupPictureUploading());
    _uploadGroupPicture.launch(group).then((_) {
      update();
    }).catchError((err, st) {
      if (err is UserCancelled) {
        showToast("User cancelled upload");
      } else {
        showError(err, st);
      }
    });
  }

  void deleteGroupPicture() {}

  void invitePersonToGroup(Person person) {
    emit(AddingPersonToGroup());
    _invitePersonToGroupUseCase.launch(group, person).then((value) {
      update();
    }).catchError((onError, st) {
      showError(onError, st);
    });
  }
}
