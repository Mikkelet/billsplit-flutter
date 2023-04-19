import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:billsplit_flutter/presentation/friends/friends_page.dart';
import 'package:billsplit_flutter/presentation/profile/bloc/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final _nameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget<ProfileCubit>(
      create: (context) => ProfileCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<ProfileCubit>();
        final person = cubit.user;
        return Scaffold(
          appBar: AppBar(leading: const BackButton()),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProfilePictureView(person: person, size: 120),
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
                            ..text = person.nameState,
                          onChanged: (val) {
                            person.nameState = val;
                          },
                        ),
                        const SizedBox(height: 16),
                        Text(person.email,
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
          ),
        );
      }),
    );
  }

  static Route<ProfilePage> getRoute() =>
      MaterialPageRoute(builder: (context) => ProfilePage());
}
