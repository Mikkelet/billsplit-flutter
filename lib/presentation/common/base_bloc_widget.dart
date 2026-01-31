import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseBlocWidget<T extends BaseCubit> extends BlocProvider<T> {
  final T Function(BuildContext) create;
  final Function(BuildContext, T, UiState)? listener;

  const BaseBlocWidget(
      {super.key, required this.create, this.listener, super.child})
      : super(create: create);

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
              listener?.call(context, context.read<T>(), state);
            }
            if (state is ShowToast) {
              _showToast(context, state.message);
            }
          },
          child: child),
    );
  }

  void _showToast(BuildContext context, String message) {
    try {
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(SnackBar(
        content: Text(message,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ));
    } catch (e) {
      // ignore
    }
  }
}
