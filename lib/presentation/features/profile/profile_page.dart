import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/base_scaffold.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/common/update_currency/update_user_default_currency_view.dart';
import 'package:billsplit_flutter/presentation/common/update_textfield/updatable_textfield.dart';
import 'package:billsplit_flutter/presentation/common/upload_profile_picture/upload_pfp_view.dart';
import 'package:billsplit_flutter/presentation/features/developer_settings/developer_settings_page.dart';
import 'package:billsplit_flutter/presentation/features/friends/friends_page.dart';
import 'package:billsplit_flutter/presentation/features/profile/bloc/profile_cubit.dart';
import 'package:billsplit_flutter/presentation/features/profile/widgets/phone_number_view.dart';
import 'package:billsplit_flutter/presentation/features/profile/widgets/signout_button.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget<ProfileCubit>(
      create: (context) => ProfileCubit(),
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
                    const SizedBox(height: 16),
                    UpdatableTextField(
                        initState: cubit.user.nameState,
                        updateFuture: cubit.updateDisplayName),
                    const SizedBox(height: 12),
                    RoundedListItem(
                      align: Alignment.centerLeft,
                      height: 64,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(cubit.user.email,
                          style: Theme.of(context).textTheme.labelLarge),
                    ),
                    const SizedBox(height: 12),
                    const PhoneNumberView(),
                    const SizedBox(height: 12),
                    UpdateUserDefaultCurrencyView<ProfileCubit>(),
                    const SizedBox(height: 12),
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
                            style: Theme.of(context).textTheme.labelLarge,
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
                    const SizedBox(height: 12),
                    ClickableListItem(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      onClick: () async {
                        await Navigator.of(context)
                            .push(DeveloperSettingsPage.getRoute());
                        cubit.update();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Developer settings",
                            style: Theme.of(context).textTheme.labelLarge,
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
                    const SizedBox(height: 12),
                    const SignOutButton(),
                    const SizedBox(height: 32),
                    FutureBuilder(
                      future: cubit.syncVersion(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Text("");
                        }
                        return Text(snapshot.data!);
                      },
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
}
