import 'package:billsplit_flutter/domain/use_cases/sign_out_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/update_profile_picture_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/profile/bloc/profile_state.dart';

class ProfileCubit extends BaseCubit {
  final signOutUseCase = SignOutUseCase();
  final updateProfilePictureUseCase = UpdateProfilePictureUseCase();

  void signOut() {
    signOutUseCase.launch().then((value) {}).catchError((error) {
      showError(error);
    });
  }

  void changeName(String name) {}

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
