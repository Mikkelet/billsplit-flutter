import 'package:billsplit_flutter/presentation/common/base_scaffold.dart';
import 'package:billsplit_flutter/presentation/common/update_currency/update_user_default_currency_view.dart';
import 'package:billsplit_flutter/presentation/common/upload_profile_picture/upload_pfp_view.dart';
import 'package:billsplit_flutter/presentation/features/delete_user_flow/delete_user_page.dart';
import 'package:billsplit_flutter/presentation/features/developer_settings/developer_settings_page.dart';
import 'package:billsplit_flutter/presentation/features/friends/friends_route.dart';
import 'package:billsplit_flutter/presentation/features/group_invites/group_invites_route.dart';
import 'package:billsplit_flutter/presentation/features/profile/bloc/profile_cubit.dart';
import 'package:billsplit_flutter/presentation/features/profile/bloc/profile_state.dart';
import 'package:billsplit_flutter/presentation/features/profile/widgets/delete_user_button.dart';
import 'package:billsplit_flutter/presentation/features/profile/widgets/edit_name_dialog.dart';
import 'package:billsplit_flutter/presentation/features/profile/widgets/phone_number_view.dart';
import 'package:billsplit_flutter/presentation/features/profile/widgets/profile_list_item.dart';
import 'package:billsplit_flutter/presentation/features/profile/widgets/signout_button.dart';
import 'package:billsplit_flutter/presentation/utils/di_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    return BlocListener<ProfileCubit, ProfileState>(
      listenWhen: (prev, curr) => prev.event != curr.event,
      listener: (context, state) {
        if (state.event == ProfileStateEvents.showDeleteUser) {
          Navigator.of(context).push(DeleteUserPage.route);
        }
      },
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return BaseScaffold(
            appBar: AppBar(
              forceMaterialTransparency: true,
              leading: const BackButton(),
            ),
            body: Builder(
              builder: (context) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const UploadProfilePictureView(),
                        const SizedBox(height: 12),
                        ProfileListItem(
                          text: context.user.displayName,
                          onClick: () async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: EditNameDialog(
                                    initState: context.user.displayName,
                                    onSubmit: (name) {
                                      cubit.updateDisplayName(name);
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        if (cubit.showProfileInfo)
                          Column(
                            children: [
                              ProfileListItem(
                                text: context.user.email,
                                icon: null,
                              ),
                              const PhoneNumberView(),
                              ProfileListItem(
                                text: "Group invites",
                                counter: state.groupInvites,
                                onClick: () {
                                  GroupInvitesRoute().push(context);
                                },
                              ),
                              ProfileListItem(
                                text: "Friends",
                                counter: state.friendInvites,
                                onClick: () async {
                                  await FriendsRoute().push(context);
                                  cubit.init();
                                },
                              ),
                            ],
                          ),
                        UpdateUserDefaultCurrencyView(),
                        if (kDebugMode)
                          ProfileListItem(
                            text: "Developer settings",
                            onClick: () async {
                              await Navigator.of(context).push(DeveloperSettingsPage.getRoute());
                            },
                          ),
                        const SizedBox(height: 32),
                        const SignOutButton(),
                        const SizedBox(height: 32),
                        const DeleteUserButton(),
                        const SizedBox(height: 32),
                        Text(state.version),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
