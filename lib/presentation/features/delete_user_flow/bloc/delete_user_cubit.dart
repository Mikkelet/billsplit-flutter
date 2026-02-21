import 'package:billsplit_flutter/domain/use_cases/profile/delete_user_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/safe_cubit.dart';
import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:billsplit_flutter/presentation/features/delete_user_flow/bloc/delete_user_state.dart';

class DeleteUserCubit extends SafeCubit<DeleteUserState> {
  final _deleteUserUseCase = DeleteUserUseCase();

  DeleteUserCubit() : super(const DeleteUserState());

  void confirmDelete() async {
    try {
      safeEmit(state.copyWith(isLoading: true));
      await _deleteUserUseCase.launch();
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.serverError(e.toString())));
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }
}
