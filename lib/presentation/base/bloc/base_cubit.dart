import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseCubit extends Cubit<BaseState> {
  BaseCubit() : super(Main());

  BaseCubit.withState(super.initialState) : super();

  void showLoading(){
    emit(Loading());
  }

  void showError(Error err){
    print(err);
    if(err is Error){
      print((err as Error).stackTrace);
    }
    emit(Failure(Exception(err)));
  }

}
