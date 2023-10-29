import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  final UiState state;
  final Widget child;

  const LoadingView({
    super.key,
    required this.state,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (state is Loading) {
      return const CircularProgressIndicator();
    }
    return child;
  }
}
