import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/common/update_currency/update_currency_view.dart';
import 'package:billsplit_flutter/presentation/common/update_textfield/updatable_textfield2.dart';
import 'package:billsplit_flutter/presentation/common/upload_profile_picture/upload_pfp_view.dart';
import 'package:billsplit_flutter/presentation/features/friends/friends_page.dart';
import 'package:billsplit_flutter/presentation/features/profile/bloc/profile_cubit.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget<ProfileCubit>(
      create: (context) => ProfileCubit(),
      child: BaseBlocBuilder<ProfileCubit>(builder: (cubit, state) {
        return Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
          ),
          body: Builder(builder: (context) {
            if (state is Loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const UploadProfilePictureView(),
                    const SizedBox(height: 16),
                    RoundedListItem(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UpdatableTextField2(
                              initState: cubit.user.nameState,
                              updateFuture: cubit.updateDisplayName),
                          const SizedBox(height: 16),
                          Text(cubit.user.email,
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    ClickableListItem(
                      onClick: () {
                        Navigator.of(context).push(FriendsPage.getRoute());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Friends"),
                          Icon(
                            Icons.arrow_right,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // default currency
                    const UpdateCurrencyView(),
                    const SizedBox(height: 32),
                    Divider(
                        endIndent: 16,
                        indent: 16,
                        color: Theme.of(context).colorScheme.inversePrimary),
                    const SizedBox(height: 32),
                    ClickableListItem(
                      onClick: () {
                        cubit.signOut();
                      },
                      color: Theme.of(context).colorScheme.error,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Sign out",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onError),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      }),
    );
  }

  static Route<ProfilePage> getRoute() =>
      MaterialPageRoute(builder: (context) => const ProfilePage());
}
