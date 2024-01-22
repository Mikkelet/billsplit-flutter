import 'package:billsplit_flutter/presentation/features/delete_user_flow/bloc/delete_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ConfirmDeleteUserButton extends StatelessWidget {
  const ConfirmDeleteUserButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DeleteUserCubit>();
    return StreamBuilder(
      stream: Stream.periodic(
          const Duration(milliseconds: 100), (x) => x * 100),
      builder: (context, snapshot) {
        final data = snapshot.data ?? 0;
        final time = 5.0 - data / 1000;
        if (time < 0.1) {
          return TextButton(
            onPressed: () {
              cubit.confirmDelete();
            },
            child: const Text("DELETE"),
          );
        }
        return Center(
          child: Text(
            NumberFormat("#.#").format(time),
          ),
        );
      },
    );
  }
}
