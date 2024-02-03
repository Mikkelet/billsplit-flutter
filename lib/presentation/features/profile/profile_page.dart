import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/base_scaffold.dart';
import 'package:billsplit_flutter/presentation/common/update_currency/update_user_default_currency_view.dart';
import 'package:billsplit_flutter/presentation/common/upload_profile_picture/upload_pfp_view.dart';
import 'package:billsplit_flutter/presentation/features/delete_user_flow/delete_user_page.dart';
import 'package:billsplit_flutter/presentation/features/developer_settings/developer_settings_page.dart';
import 'package:billsplit_flutter/presentation/features/friends/friends_page.dart';
import 'package:billsplit_flutter/presentation/features/group_invites/group_invites_page.dart';
import 'package:billsplit_flutter/presentation/features/profile/bloc/profile_cubit.dart';
import 'package:billsplit_flutter/presentation/features/profile/bloc/profile_state.dart';
import 'package:billsplit_flutter/presentation/features/profile/widgets/delete_user_button.dart';
import 'package:billsplit_flutter/presentation/features/profile/widgets/edit_name_dialog.dart';
import 'package:billsplit_flutter/presentation/features/profile/widgets/phone_number_view.dart';
import 'package:billsplit_flutter/presentation/features/profile/widgets/profile_list_item.dart';
import 'package:billsplit_flutter/presentation/features/profile/widgets/signout_button.dart';
import 'package:billsplit_flutter/presentation/mutable_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget<ProfileCubit>(
      create: (context) => ProfileCubit()..loadNotifications(),
      listener: (context, cubit, state) {
        if (state is ShowDeleteUser) {
          Navigator.of(context).push(DeleteUserPage.route);
        }
      },
      child: BaseBlocBuilder<ProfileCubit>(builder: (cubit, state) {
        return BaseScaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            leading: const BackButton(),
          ),
          body: Builder(builder: (context) {
            if (state is Loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const UploadProfilePictureView(),
                    const SizedBox(height: 12),
                    MutableValue(
                        mutableValue: cubit.user.nameState,
                        builder: (context, name) {
                          return ProfileListItem(
                            text: cubit.user.displayName,
                            onClick: () async {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: EditNameDialog(
                                      initState: cubit.user.displayName,
                                      onSubmit: (name) {
                                        cubit.updateDisplayName(name);
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        }),
                    if (cubit.showProfileInfo)
                      Column(
                        children: [
                          ProfileListItem(
                            text: cubit.user.email,
                            icon: null,
                          ),
                          const PhoneNumberView<ProfileCubit>(),
                          MutableValue(
                              mutableValue: cubit.groupInvitesCounter,
                              builder: (context, groupsCounter) {
                                return ProfileListItem(
                                  text: "Group invites",
                                  counter: groupsCounter,
                                  onClick: () {
                                    Navigator.of(context)
                                        .push(GroupInvitesPage.route);
                                  },
                                );
                              }),
                          MutableValue(
                              mutableValue: cubit.friendsCounter,
                              builder: (context, counter) {
                                return ProfileListItem(
                                    text: "Friends",
                                    counter: counter,
                                    onClick: () async {
                                      await Navigator.of(context)
                                          .push(FriendsPage.route);
                                      cubit.loadNotifications();
                                    });
                              }),
                        ],
                      ),
                    UpdateUserDefaultCurrencyView<ProfileCubit>(),
                    if (kDebugMode)
                      ProfileListItem(
                          text: "Developer settings",
                          onClick: () async {
                            await Navigator.of(context)
                                .push(DeveloperSettingsPage.getRoute());
                            cubit.update();
                          }),
                    const SizedBox(height: 32),
                    const SignOutButton(),
                    const SizedBox(height: 32),
                    const DeleteUserButton(),
                    const SizedBox(height: 32),
                    MutableText(mutString: cubit.appVersionState),
                  ],
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}
