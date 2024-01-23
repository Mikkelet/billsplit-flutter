import 'package:billsplit_flutter/domain/use_cases/profile/delete_user_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';

class DeleteUserCubit extends BaseCubit {
  final _deleteUserUseCase = DeleteUserUseCase();

  void confirmDelete() {
    showLoading();
    _deleteUserUseCase.launch().then((_) {}).catchError((err, st) {
      showError(err, st);
    });
  }
}
