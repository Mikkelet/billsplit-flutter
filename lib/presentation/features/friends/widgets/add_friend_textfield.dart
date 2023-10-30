import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/features/friends/bloc/add_friend_cubit.dart';
import 'package:billsplit_flutter/presentation/features/friends/widgets/add_friend_email_view.dart';
import 'package:billsplit_flutter/presentation/features/friends/widgets/add_friend_phone_view.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFriendView extends StatefulWidget {
  const AddFriendView({super.key});

  @override
  State<AddFriendView> createState() => _AddFriendViewState();
}

class _AddFriendViewState extends SafeState<AddFriendView> {
  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget(
      create: (context) => AddFriendCubit(),
      child: BaseBlocBuilder<AddFriendCubit>(
        builder: (cubit, state) {
          return Column(
            children: [
              Builder(
                builder: (context) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Add friend",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(width: 8),
                      ClickableListItem(
                        color: _getAddFriendTypeColor(
                            context, AddFriendType.phone),
                        onClick: () {
                          cubit.onAddFriendTypeClicked(AddFriendType.phone);
                        },
                        child: const Icon(Icons.phone),
                      ),

                      const SizedBox(width: 8),
                      ClickableListItem(
                        color: _getAddFriendTypeColor(
                            context, AddFriendType.email),
                        onClick: () {
                          cubit.onAddFriendTypeClicked(AddFriendType.email);
                        },
                        child: const Icon(Icons.email),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 8),
              Builder(builder: (context) {
                switch (cubit.selectedAddFriendType) {
                  case AddFriendType.email:
                    return AddFriendEmailView();
                  case AddFriendType.phone:
                    return AddFriendPhoneView();
                  default:
                    return const SizedBox();
                }
              })
            ],
          );
        },
      ),
    );
  }

  Color? _getAddFriendTypeColor(
      BuildContext context, AddFriendType addFriendType) {
    final cubit = context.read<AddFriendCubit>();
    final selectedType = cubit.selectedAddFriendType;
    if (selectedType == addFriendType) {
      return Theme.of(context).colorScheme.secondaryContainer;
    }
    return null;
  }
}
