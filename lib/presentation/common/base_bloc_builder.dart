import 'package:billsplit_flutter/presentation/base/bloc/base_cubit.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseBlocBuilder<T extends BaseCubit> extends StatelessWidget {
  final Widget Function(T, UiState) builder;

  const BaseBlocBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<T, UiState>(builder: (context, state) {
      final cubit = context.read<T>();
      return builder(cubit, state);
    });
  }
}
