import 'package:billsplit_flutter/domain/use_cases/add_friend_email_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/add_friend_uid_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';

class AddFriendCubit extends BaseCubit {
  final _addFriendUserIdUseCase = AddFriendUserIdUseCase();
  final _addFriendEmailUseCase = AddFriendEmailUseCase();

  void addFriendUserId(String userId) {
    emit(Loading());
    _addFriendUserIdUseCase.launch(userId).then((value) {
      emit(Main());
    }).catchError((err, st) {
      showError(err, st);
    });
  }

  void addFriendEmail(String email) {
    emit(Loading());
    _addFriendEmailUseCase.launch(email).then((value) {
      emit(Main());
    }).catchError((err, st) {
      showError(err, st);
    });
  }
}
