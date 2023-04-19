import 'package:billsplit_flutter/presentation/add_group/bloc/add_group_cubit.dart';
import 'package:billsplit_flutter/presentation/add_group/widgets/add_people_to_group_view.dart';
import 'package:billsplit_flutter/presentation/add_group/widgets/added_person_view.dart';
import 'package:billsplit_flutter/presentation/base/bloc/base_state.dart';
import 'package:billsplit_flutter/presentation/common/base_bloc_widget.dart';
import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddGroupPage extends StatelessWidget {
  AddGroupPage({Key? key}) : super(key: key);

  final nameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseBlocWidget(
      create: (context) => AddGroupCubit(),
      child: BlocBuilder<AddGroupCubit, UiState>(
        builder: (context, state) {
          final cubit = context.read<AddGroupCubit>();
          return Scaffold(
            appBar: AppBar(
              leading: const BackButton(),
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
                    RoundedListItem(
                        child: TextField(
                      controller: nameTextController,
                      decoration: const InputDecoration(border: InputBorder.none, hintText: "New group"),
                    )),
                    Container(height: 16),
                    RoundedListItem(
                      child: Column(
                        children: [
                          cubit.people.isEmpty ? const Text("Add people to the group") : const SizedBox(),
                          ...cubit.people
                              .map((e) => AddedPersonView(person: e))
                              .toList(),
                          Container(height: 12),
                          const Align(
                              alignment: Alignment.centerRight,
                              child: AddPeopleToGroupView()),
                        ],
                      ),
                    ),
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
