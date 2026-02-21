import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/safe_cubit.dart';
import 'package:billsplit_flutter/presentation/base/errors.dart';
import 'package:billsplit_flutter/presentation/common/update_textfield/update_textfield_state.dart';
import 'package:flutter/cupertino.dart';

class UpdateTextFieldCubit extends SafeCubit<UpdatableTextFieldState> {
  final Future Function(String) _updateFuture;
  final String initText;
  late final controller = TextEditingController(text: initText);

  UpdateTextFieldCubit(this._updateFuture, this.initText) : super(UpdatableTextFieldState());

  void onUpdatePressed() async {
    if (initText == controller.text) return;
    try {
      safeEmit(state.copyWith(isLoading: true));
      await _updateFuture(controller.text);
    } catch (e, st) {
      logError(e, st);
      safeEmit(state.copyWith(error: SplitsbyError.serverError(e.toString())));
    } finally {
      safeEmit(state.copyWith(isLoading: false));
    }
  }

  void onEditPressed() {
    safeEmit(state.copyWith(view: UpdatableTextFieldView.edit));
  }

  void onCancelPressed() {
    safeEmit(state.copyWith(view: UpdatableTextFieldView.display));
    controller.text = initText;
  }
}
