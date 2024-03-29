import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:flutter/material.dart';

class PersonPickerDialog extends StatelessWidget {
  final Iterable<Person> people;
  final void Function(Person) onClick;

  const PersonPickerDialog(
      {required this.people, required this.onClick, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...people.map(
              (person) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ProfilePictureView(person: person),
                      const SizedBox(width: 8),
                      Text(
                        person.displayName,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () => onClick(person),
                    child: const Text("invite"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
