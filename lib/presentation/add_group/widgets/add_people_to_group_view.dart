import 'package:billsplit_flutter/presentation/add_group/bloc/add_group_cubit.dart';
import 'package:billsplit_flutter/presentation/dialogs/person_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPeopleToGroupView extends StatelessWidget {
  const AddPeopleToGroupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddGroupCubit>();
    return CircleAvatar(
        backgroundColor: Colors.purple,
        child: IconButton(
            icon: const Icon(Icons.add),
            color: Colors.white,
            onPressed: () {
              cubit.friendsStream.first.then((value) {
                showDialog(
                    context: context,
                    builder: (context) => PersonPickerDialog(
                        people: value.toList(),
                        onClick: (person) {
                          cubit.onAddPerson(person);
                          Navigator.of(context).pop();
                        }));
              });
            }));
  }
}
