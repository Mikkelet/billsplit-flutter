import 'package:billsplit_flutter/domain/use_cases/sign_out_usecase.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';

class ProfileCubit extends BaseCubit {
  final signOutUseCase = SignOutUseCase();

  void signOut() {
    signOutUseCase
        .launch()
        .then((value) => {})
        .catchError((error) => showError(error));
  }

  void changeProfilePic(){

  }

  void changeName(String name){

  }


}
