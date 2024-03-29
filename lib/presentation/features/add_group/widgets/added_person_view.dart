import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/add_group_cubit.dart';

class AddedPersonView extends StatelessWidget {
  final Person person;

  const AddedPersonView({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddGroupCubit>();
    final showRemoveButton = person.uid == cubit.user.uid;
    return Row(
      children: [
        ProfilePictureView(person: person),
        const SizedBox(width: 8),
        Text(
          person.displayName,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const Flexible(
            child: SizedBox(
          width: double.infinity,
        )),
        !showRemoveButton
            ? IconButton(
                onPressed: () {
                  cubit.removePerson(person);
                },
                color: Colors.red,
                icon: const Icon(Icons.remove))
            : const SizedBox()
      ],
    );
  }
}
