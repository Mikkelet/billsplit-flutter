import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/features/friends/bloc/add_friend_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendRequestReceivedView extends StatelessWidget {
  final Person person;

  const FriendRequestReceivedView({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(person.displayName),
        BlocBuilder<AddFriendCubit, UiState>(builder: (context, state) {
          if (state is Loading) {
            return const CircularProgressIndicator(color: Colors.white,);
          }
          if (state is Failure) {
            return Text("${state.error}");
          }
          return MaterialButton(
            padding: EdgeInsets.zero,
            color: Colors.greenAccent,
            elevation: 0,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            onPressed: () {
              context.read<AddFriendCubit>().addFriendUserId(person.uid);
            },
            child: const Text("Accept"),
          );
        })
      ],
    );
  }
}
