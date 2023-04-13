import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/friends/friends_page.dart';
import 'package:billsplit_flutter/presentation/profile/bloc/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final _nameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final person = Person.dummy(0);
    return BlocProvider<ProfileCubit>(
      create: (context) => ProfileCubit(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<ProfileCubit>();
          return Scaffold(
            appBar: AppBar(leading: const BackButton()),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _nameTextController..text = person.nameState,
                    onChanged: (val) {
                      person.nameState = val;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(person.nameState),
                ),
                MaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(FriendsPage.getRoute());
                    },
                    elevation: 0,
                    color: Colors.grey,
                    child: const Text("Friends")),
                MaterialButton(
                    onPressed: () {
                      cubit.signOut();
                    },
                    elevation: 0,
                    color: Colors.redAccent,
                    child: const Text("Sign out")),
              ],
            ),
          );
        }
      ),
    );
  }

  static Route<ProfilePage> getRoute() =>
      MaterialPageRoute(builder: (context) => ProfilePage());
}
