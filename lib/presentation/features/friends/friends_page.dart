import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/default_stream_builder.dart';
import 'package:billsplit_flutter/presentation/features/friends/bloc/friends_cubit.dart';
import 'package:billsplit_flutter/presentation/features/friends/widgets/add_friend_textfield.dart';
import 'package:billsplit_flutter/presentation/features/friends/widgets/friend_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget(
      create: (context) => FriendsCubit()..getFriends(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: const Text("Friends"),
          leading: const BackButton(),
        ),
        body: Builder(
          builder: (context) {
            final cubit = context.read<FriendsCubit>();
            return RefreshIndicator(
              onRefresh: () async {
                await cubit.refreshFriends();
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 16),
                      const AddFriendTextField(),
                      const SizedBox(height: 16),
                      DefaultStreamBuilder(
                        stream: cubit.friendsStream(),
                        body: (friends) {
                          if (cubit.state is Loading && friends.isEmpty) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (friends.isEmpty) {
                            return const Text("Type an email above to add a friend!");
                          }
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ...friends
                                  .map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: FriendView(friend: e),
                                    ),
                                  )
                                  .toList()
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
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
