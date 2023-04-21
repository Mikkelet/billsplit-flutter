import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_builder.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/friends/friends_page.dart';
import 'package:billsplit_flutter/presentation/profile/bloc/profile_cubit.dart';
import 'package:billsplit_flutter/presentation/profile/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final _nameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget<ProfileCubit>(
      create: (context) => ProfileCubit(),
      child: BaseBlocBuilder<ProfileCubit>(builder: (cubit, state) {
        return Scaffold(
          appBar: AppBar(leading: const BackButton()),
          body: Builder(builder: (context) {
            if (state is Loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _updateProfilePicture(cubit);
                      },
                      child: Builder(
                        builder: (context) {
                          if (state is ProfilePictureUploading) {
                            return const SizedBox(
                                width: 120,
                                height: 120,
                                child: CircularProgressIndicator());
                          }
                          return ProfilePictureView(
                              person: cubit.user, size: 120);
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    RoundedListItem(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                            maxLines: 1,
                            controller: _nameTextController
                              ..text = cubit.user.nameState,
                            onChanged: (val) {
                              cubit.user.nameState = val;
                            },
                          ),
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
                        children: const [
                          Text("Friends"),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Divider(endIndent: 16, indent: 16),
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

  Future _updateProfilePicture(ProfileCubit cubit) async {
    print("qqq click");
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      cubit.updateProfilePicture(file.path);
    }
  }

  static Route<ProfilePage> getRoute() =>
      MaterialPageRoute(builder: (context) => ProfilePage());
}
