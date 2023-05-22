import 'package:billsplit_flutter/domain/models/currency.dart';
import 'package:billsplit_flutter/domain/use_cases/sign_out_usecase.dart';
import 'package:billsplit_flutter/domain/use_cases/update_display_name_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/updatable_textfield.dart';

class ProfileCubit extends BaseCubit {
  final _signOutUseCase = SignOutUseCase();
  final _updateDisplayNameUseCase = UpdateDisplayNameUseCase();

  UpdateTextFieldState updateDisplayNameState = UpdateTextFieldState.display;

  void signOut() {
    _signOutUseCase.launch().then((value) {}).catchError((error, st) {
      showError(error, st);
    });
  }

  editDisplayName(bool isEditing) {
    if (isEditing) {
      _updateDisplayNameState(UpdateTextFieldState.isEditing);
    } else {
      _updateDisplayNameState(UpdateTextFieldState.display);
    }
  }

  _updateDisplayNameState(UpdateTextFieldState state) {
    updateDisplayNameState = state;
    emit(Main());
  }

  Future updateDisplayName(String newName) async {
    await _updateDisplayNameUseCase.launch(newName);
    user.nameState = newName;
  }

  void updateCurrency(Currency currency) {
    sharedPrefs.userPrefDefaultCurrency = currency.symbol;
    emit(Main());
  }

}
