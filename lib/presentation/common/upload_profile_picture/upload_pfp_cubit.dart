import 'package:billsplit_flutter/domain/use_cases/profile/delete_profile_picture_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/profile/update_profile_picture_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/safe_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../_generated/presentation/common/upload_profile_picture/upload_pfp_cubit.freezed.dart';

class UploadProfilePictureCubit extends SafeCubit<UploadProfilePictureState> {
  final _updateProfilePictureUseCase = UpdateProfilePictureUseCase();
  final _deleteProfilePicture = DeleteProfilePictureUseCase();

  UploadProfilePictureCubit() : super(const UploadProfilePictureState());

  Future<void> updateProfilePicture() async {
    try {
        safeEmit(state.copyWith(isLoading: true));
        final picker = ImagePicker();
        final file = await picker.pickImage(source: ImageSource.gallery);
        if (file != null) {
          _updateProfilePicture(file.path);
        }
    } catch(e, st) {
        logError(e, st);
        safeEmit(state.copyWith(error: SplitsbyError.serverError(e.toString())));
    } finally {
        safeEmit(state.copyWith(isLoading: false));
    }
  }

  void _updateProfilePicture(String path) async {
    try {
      final uri = Uri(path: path);
      safeEmit(state.copyWith(isLoading: true));
      await _updateProfilePictureUseCase.launch(uri);
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.serverError(e.toString())));
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }

  void deleteProfilePicture() async {
    try {
      safeEmit(state.copyWith(isLoading: true));
      await _deleteProfilePicture.launch();
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.serverError(e.toString())));
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }
}

@freezed
abstract class UploadProfilePictureState with _$UploadProfilePictureState {
  const factory UploadProfilePictureState({
    @Default(false) bool isLoading,
    @Default(SplitsbyError.none()) SplitsbyError error,
  }) = _UploadProfilePictureState;
}
