import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/default_stream_builder.dart';
import 'package:billsplit_flutter/presentation/friends/bloc/friends_cubit.dart';
import 'package:billsplit_flutter/presentation/friends/widgets/add_friend_textfield.dart';
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
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DefaultStreamBuilder(
                stream: cubit.friendsStream(),
                body: (friends) {
                  final lsFriends = friends.toList();
                  if (cubit.state is Loading && friends.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (friends.isEmpty) {
                    return const Text("No friends");
                  }
                  return ListView.builder(
                    itemCount: friends.length + 1,
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return AddFriendTextField();
                      }
                      final i = index - 1;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FriendView(friend: lsFriends[i]),
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  static Route<FriendsPage> getRoute() {
    return MaterialPageRoute(builder: (context) => const FriendsPage());
  }
}
