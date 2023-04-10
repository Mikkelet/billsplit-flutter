import 'package:billsplit_flutter/data/auth/auth_provider.dart';
import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:drift/isolate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseCubit extends Cubit<UiState> {

  final authProvider = AuthProvider.instance;

  BaseCubit() : super(Main());

  BaseCubit.withState(super.initialState) : super();

  void showLoading() {
    emit(Loading());
  }

  void showError(dynamic err) {
    if (err is Error) {
      print(err);
      print((err as Error).stackTrace);
    } else if (err is DriftRemoteException) {
      print(err.remoteCause);
      print(err.remoteStackTrace);
    } else {
      print(err);
    }
    emit(Failure(Exception(err)));
  }

  Person get user => authProvider.user!;
}
