import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/common/update_currency/update_user_default_currency_view.dart';
import 'package:billsplit_flutter/presentation/common/update_textfield/updatable_textfield.dart';
import 'package:billsplit_flutter/presentation/common/upload_profile_picture/upload_pfp_view.dart';
import 'package:billsplit_flutter/presentation/features/developer_settings/developer_settings_page.dart';
import 'package:billsplit_flutter/presentation/features/friends/friends_page.dart';
import 'package:billsplit_flutter/presentation/features/profile/bloc/profile_cubit.dart';
import 'package:billsplit_flutter/presentation/features/profile/widgets/signout_button.dart';
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
                    UpdatableTextField(
                        initState: cubit.user.nameState,
                        updateFuture: cubit.updateDisplayName),
                    const SizedBox(height: 4),
                    RoundedListItem(
                      align: Alignment.centerLeft,
                      height: 64,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(30),
                          bottom: Radius.circular(30)),
                      child: Text(cubit.user.email,
                          style: Theme.of(context).textTheme.labelLarge),
                    ),
                    const SizedBox(height: 4),
                    const UpdateUserDefaultCurrencyView(),
                    const SizedBox(height: 4),
                    ClickableListItem(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      onClick: () {
                        Navigator.of(context).push(FriendsPage.getRoute());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Friends",
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Icon(
                            Icons.arrow_right,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    ClickableListItem(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      onClick: () {
                        Navigator.of(context)
                            .push(DeveloperSettingsPage.getRoute());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Developer settings",
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Icon(
                            Icons.code,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Divider(
                        endIndent: 16,
                        indent: 16,
                        color: Theme.of(context).colorScheme.inversePrimary),
                    const SizedBox(height: 32),
                    const SignOutButton(),
                  ],
                ),
              ),
            );
          }),
        );
      }),
    );
  }

  static Route getRoute() =>
      MaterialPageRoute(builder: (context) => const ProfilePage());
}
