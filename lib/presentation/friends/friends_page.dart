import 'package:billsplit_flutter/presentation/common/default_stream_builder.dart';
import 'package:billsplit_flutter/presentation/friends/bloc/friends_cubit.dart';
import 'package:billsplit_flutter/presentation/friends/widgets/friend_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FriendsCubit()..getFriends(),
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
        ),
        body: Builder(
          builder: (context) {
            final cubit = context.read<FriendsCubit>();
            return DefaultStreamBuilder(
                stream: cubit.friendsStream(),
                noData: const Text("No friends"),
                listItem: (friend) => FriendView(friend: friend));
          },
        ),
      ),
    );
  }

  static Route<FriendsPage> getRoute() {
    return MaterialPageRoute(builder: (context) => const FriendsPage());
  }
}
