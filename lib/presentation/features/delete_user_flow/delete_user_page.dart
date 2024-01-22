import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/base_scaffold.dart';
import 'package:billsplit_flutter/presentation/features/delete_user_flow/bloc/confirm_delete_user_button.dart';
import 'package:billsplit_flutter/presentation/features/delete_user_flow/bloc/delete_user_cubit.dart';
import 'package:billsplit_flutter/presentation/utils/routing_utils.dart';
import 'package:flutter/material.dart';

class DeleteUserPage extends StatelessWidget {
  const DeleteUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget(
      create: (context) => DeleteUserCubit(),
      child: BaseBlocBuilder<DeleteUserCubit>(builder: (cubit, state) {
        return BaseScaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            leading: const BackButton(),
          ),
          body: Builder(builder: (context) {
            if (state is Loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    const SizedBox(height: 64),
                    Text("You are about to delete your profile",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: Colors.red)),
                    const SizedBox(height: 16),
                    Text(
                        "Deleting your profile will also delete all of your data, such as profile picture, email, name, phone number",
                        style: Theme.of(context).textTheme.labelSmall),
                    const SizedBox(height: 8),
                    Text(
                        "Your groups will not be deleted, but you will be anonymized and any association to them will be removed",
                        style: Theme.of(context).textTheme.labelSmall),
                    const SizedBox(height: 8),
                    const ConfirmDeleteUserButton()
                  ],
                ),
              ),
            );
          }),
        );
      }),
    );
  }

  static get route =>
      slideUpRoute(const DeleteUserPage(), routeName: "/deleteUser");
}
