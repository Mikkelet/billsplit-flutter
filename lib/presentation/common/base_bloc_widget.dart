import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseBlocWidget<T extends BaseCubit> extends StatelessWidget {
  final T Function(BuildContext) create;
  final Function(UiState)? listener;
  final Widget child;

  const BaseBlocWidget(
      {super.key,
      required this.create,
      this.listener,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => create(context),
      child: BlocListener<T, UiState>(
          listener: (context, state) {
            if (state is Failure) {
              showDialog(
                  context: context,
                  builder: (context) => ErrorDialog(state.error));
            } else {
              listener?.call(state);
            }
          },
          child: child),
    );
  }
}
