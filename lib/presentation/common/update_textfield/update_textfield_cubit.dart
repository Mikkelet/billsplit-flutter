import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/common/update_textfield/update_textfield_state.dart';

class UpdateTextFieldCubit extends BaseCubit {
  final Future Function(String) _updateFuture;

  UpdateTextFieldCubit(this._updateFuture) : super.withState(DisplayText());

  void onUpdatePressed(String currentState) {
    showLoading();
    _updateFuture(currentState).then((value) {
      emit(DisplayText());
    }).catchError((err, st) {
      showError(err, st);
    });
  }

  void onEditPressed(){
    emit(EditTextField());
  }

  void onCancelPressed(){
    emit(DisplayText());
  }
}
