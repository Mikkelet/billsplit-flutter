import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/shared_expense.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:flutter/material.dart';

class SharedExpensePeoplePickerDialog extends StatefulWidget {
  final SharedExpense sharedExpense;
  final List<Person> people;
  final Function() onUpdate;

  const SharedExpensePeoplePickerDialog(
      {Key? key,
      required this.sharedExpense,
      required this.people,
      required this.onUpdate})
      : super(key: key);

  @override
  State<SharedExpensePeoplePickerDialog> createState() =>
      _SharedExpensePeoplePickerDialogState();
}

class _SharedExpensePeoplePickerDialogState
    extends State<SharedExpensePeoplePickerDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...widget.people.map((person) => Row(
                  children: [
                    ProfilePictureView(person: person),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(person.nameState),
                    const Expanded(child: SizedBox()),
                    Checkbox(
                        value: widget.sharedExpense.participantsState
                            .contains(person),
                        onChanged: (newValue) {
                          widget.sharedExpense.changeParticipantState(
                              person, newValue ?? false);
                          setState(() {});
                          widget.onUpdate();
                        })
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
