import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/loading_view.dart';
import 'package:billsplit_flutter/presentation/common/simple_button.dart';
import 'package:billsplit_flutter/presentation/dialogs/friend_picker/friend_picker_cubit.dart';
import 'package:billsplit_flutter/presentation/features/friends/friends_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class NoFriendsDialog extends StatelessWidget {

  const NoFriendsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FriendPickerCubit>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "No friends",
            style: Theme
                .of(context)
                .textTheme
                .titleLarge,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SimpleButton(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .primaryContainer,
                  onClick: () {
                    Navigator.of(context).push(FriendsPage.route);
                  },
                  child: const Text("Go to friends")),
              Builder(builder: (context) {
                return LoadingView(
                  isLoading: cubit.state is Loading,
                  child: IconButton(
                      icon: const Icon(Icons.refresh),
                      color: Theme
                          .of(context)
                          .colorScheme
                          .primary,
                      onPressed: () {
                        cubit.onLoadFriends();
                      }),
                );
              })
            ],
          )
        ],
      ),
    );
  }
}
