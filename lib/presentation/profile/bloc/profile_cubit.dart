import 'package:billsplit_flutter/domain/use_cases/sign_out_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/update_display_name_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/update_profile_picture_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/profile/bloc/profile_state.dart';

class ProfileCubit extends BaseCubit {
  final signOutUseCase = SignOutUseCase();
  final updateProfilePictureUseCase = UpdateProfilePictureUseCase();
  final updateDisplayNameUseCase = UpdateDisplayNameUseCase();

  void signOut() {
    signOutUseCase.launch().then((value) {}).catchError((error) {
      showError(error);
    });
  }

  void changeName() {
    emit(UpdateDisplayNameLoading());
    updateDisplayNameUseCase.launch(user.nameState).then((value) {
      emit(DisplayNameUpdated());
    }).catchError((err) {
      showError(err);
    });
  }

  void updateProfilePicture(String path) {
    emit(ProfilePictureUploading());
    updateProfilePictureUseCase.launch(Uri(path: path)).then((value) {
      user.pfpUrlState = value;
      emit(Main());
    }).catchError((err) {
      showError(err);
    });
  }
}
