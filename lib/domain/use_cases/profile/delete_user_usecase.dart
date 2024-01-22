import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/di/get_it.dart';
import 'package:billsplit_flutter/domain/use_cases/susi/sign_out_usecase.dart';

class DeleteUserUseCase {
  final _apiService = getIt<ApiService>();
  final _signoutUseCase = SignOutUseCase();


  Future launch() async {
    await _apiService.deleteUser();
    await _signoutUseCase.launch();
  }
}
