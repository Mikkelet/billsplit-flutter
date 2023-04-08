import 'package:billsplit_flutter/presentation/add_group/widgets/add_people_to_group_view.dart';
import 'package:flutter/material.dart';

class AddGroupPage extends StatelessWidget {
  AddGroupPage({Key? key}) : super(key: key);

  final nameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(height: 40),
          const Text("Name"),
          TextField(controller: nameTextController),
          Container(height: 12),
          const Text("Add people"),
          const AddPeopleToGroupView(),
          MaterialButton(onPressed: () {}, child: const Text("Add group"))
        ],
      ),
    );
  }

  static Route<AddGroupPage> getRoute() =>
      MaterialPageRoute(builder: (context) => AddGroupPage());
}
