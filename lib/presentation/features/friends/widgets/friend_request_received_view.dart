import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/features/friends/bloc/friends_cubit.dart';
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
        MaterialButton(
          padding: EdgeInsets.zero,
          color: Colors.greenAccent,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          onPressed: () {
            context.read<FriendsCubit>().addFriendUserId(person.uid);
          },
          child: const Text("Accept"),
        ),
      ],
    );
  }
}
