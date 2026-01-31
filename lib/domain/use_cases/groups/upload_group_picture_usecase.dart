import 'package:billsplit_flutter/data/remote/storage/storage_provider.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/use_cases/groups/add_group_usecase.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UserCancelled implements Exception {}

class UploadGroupPictureUseCase {
  final _storageProvider = getIt<FirebaseStorageProvider>();
  final _addGroupUseCase = AddGroupUseCase();

  Future launch(Group group) async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      final imageCropper = ImageCropper();
      final croppedImage = await imageCropper.cropImage(
        sourcePath: file.path,
        aspectRatio: const CropAspectRatio(ratioX: 3, ratioY: 1),
      );
      if (croppedImage == null) throw UserCancelled();
      final downloadUrl = await _storageProvider.uploadGroupPicture(
          group.id, Uri(path: croppedImage.path));
      group.coverImageUrlState.value = downloadUrl;
      await _addGroupUseCase.launch(group);
    }
  }
}
