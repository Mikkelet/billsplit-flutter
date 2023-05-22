import 'package:billsplit_flutter/domain/use_cases/update_profile_picture_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:image_picker/image_picker.dart';

class UploadProfilePictureCubit extends BaseCubit {
  final _updateProfilePictureUseCase = UpdateProfilePictureUseCase();

  Future updateProfilePicture() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      _updateProfilePicture(file.path);
    }
  }

  void _updateProfilePicture(String path) {
    showLoading();
    _updateProfilePictureUseCase.launch(Uri(path: path)).then((value) {
      user.pfpUrlState = value;
      emit(Main());
    }).catchError((err, st) {
      showError(err, st);
    });
  }
}
