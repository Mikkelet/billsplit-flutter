import 'package:billsplit_flutter/domain/use_cases/update_display_name_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';

class UpdateNameCubit extends BaseCubit {
  final _updateNameUseCase = UpdateDisplayNameUseCase();

  Future updateName(String name) async {
    await _updateNameUseCase.launch(name);
    user.nameState = name;
  }
}