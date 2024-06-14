import 'package:billsplit_flutter/domain/use_cases/profile/delete_profile_picture_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/profile/update_profile_picture_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:image_picker/image_picker.dart';

class UploadProfilePictureCubit extends BaseCubit {
  final _updateProfilePictureUseCase = UpdateProfilePictureUseCase();
  final _deleteProfilePicture = DeleteProfilePictureUseCase();

  Future updateProfilePicture() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      _updateProfilePicture(file.path);
    }
  }

  void _updateProfilePicture(String path) {
    showLoading();
    final uri = Uri(path: path);
    _updateProfilePictureUseCase.launch(uri).then((value) {
      update();
    }).catchError((err, st) {
      update();
      showError(err, st);
    });
  }

  void deleteProfilePicture() {
    showLoading();
    _deleteProfilePicture.launch().then((value) {
      update();
    }).catchError((err, stackTrace) {
      update();
      showError(err, stackTrace);
    });
  }
}
