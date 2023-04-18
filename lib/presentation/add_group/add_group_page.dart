import 'package:billsplit_flutter/presentation/add_group/bloc/add_group_cubit.dart';
import 'package:billsplit_flutter/presentation/add_group/widgets/add_people_to_group_view.dart';
import 'package:billsplit_flutter/presentation/add_group/widgets/added_person_view.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddGroupPage extends StatelessWidget {
  AddGroupPage({Key? key}) : super(key: key);

  final nameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddGroupCubit(),
      child: BlocBuilder<AddGroupCubit, UiState>(
        builder: (context, state) {
          final cubit = context.read<AddGroupCubit>();
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.check))
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(height: 40),
                    const Text("Name"),
                    TextField(controller: nameTextController),
                    Container(height: 16),
                    ...cubit.people.map((e) => AddedPersonView(person: e)).toList(),
                    Container(height: 12),
                    const Align(
                      alignment: Alignment.centerRight,
                        child: AddPeopleToGroupView()),
                    MaterialButton(onPressed: () {}, child: const Text("Add group"))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  static Route<AddGroupPage> getRoute() =>
      MaterialPageRoute(builder: (context) => AddGroupPage());
}
