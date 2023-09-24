import 'package:billsplit_flutter/data/remote/storage/storage_provider.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/models/group.dart';
import 'package:billsplit_flutter/domain/use_cases/add_group_usecase.dart';
import 'package:image_picker/image_picker.dart';

class UploadGroupPictureUseCase {
  final _storageProvider = getIt<FirebaseStorageProvider>();
  final _addGroupUseCase = AddGroupUseCase();

  Future launch(Group group) async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      final uri = Uri(path: file.path);
      final downloadUrl = await _storageProvider.uploadGroupPicture(group.id, uri);
      group.coverImageUrlState = downloadUrl;
      await _addGroupUseCase.launch(group);
    }
  }
}