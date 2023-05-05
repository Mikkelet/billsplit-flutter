import 'package:billsplit_flutter/domain/use_cases/sign_out_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/update_display_name_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/update_profile_picture_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/updatable_textfield.dart';
import 'package:billsplit_flutter/presentation/features/profile/bloc/profile_state.dart';

class ProfileCubit extends BaseCubit {
  final _signOutUseCase = SignOutUseCase();
  final _updateProfilePictureUseCase = UpdateProfilePictureUseCase();
  final _updateDisplayNameUseCase = UpdateDisplayNameUseCase();

  UpdateTextFieldState updateDisplayNameState = UpdateTextFieldState.display;

  void signOut() {
    _signOutUseCase.launch().then((value) {}).catchError((error) {
      showError(error);
    });
  }

  void updateProfilePicture(String path) {
    emit(ProfilePictureUploading());
    _updateProfilePictureUseCase.launch(Uri(path: path)).then((value) {
      user.pfpUrlState = value;
      emit(Main());
    }).catchError((err) {
      showError(err);
    });
  }

  editDisplayName(bool isEditing) {
    if (isEditing) {
      _updateDisplayNameState(UpdateTextFieldState.isEditing);
    } else {
      _updateDisplayNameState(UpdateTextFieldState.display);
    }
  }

  _updateDisplayNameState(UpdateTextFieldState state) {
    updateDisplayNameState = state;
    emit(Main());
  }

  updateDisplayName() {
    _updateDisplayNameState(UpdateTextFieldState.isUpdating);
    _updateDisplayNameUseCase.launch(user.nameState).then((value) {
      _updateDisplayNameState(UpdateTextFieldState.display);
    }).catchError((error) {
      showError(error);
      _updateDisplayNameState(UpdateTextFieldState.display);
    });
  }
}
