import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/domain/models/shared_expense.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:billsplit_flutter/presentation/mutable_state.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:flutter/material.dart';

class SharedExpensePeoplePickerDialog extends StatefulWidget {
  final SharedExpense sharedExpense;
  final List<Person> people;
  final Function() onRemove;

  const SharedExpensePeoplePickerDialog({
    super.key,
    required this.sharedExpense,
    required this.people,
    required this.onRemove,
  });

  @override
  State<SharedExpensePeoplePickerDialog> createState() =>
      _SharedExpensePeoplePickerDialogState();
}

class _SharedExpensePeoplePickerDialogState
    extends SafeState<SharedExpensePeoplePickerDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...widget.people.map(
            (person) => Row(
              children: [
                ProfilePictureView(person: person),
                const SizedBox(width: 16),
                Text(person.displayName),
                const Expanded(child: SizedBox()),
                MutableValue(
                    mutableValue: widget.sharedExpense.participantsState,
                    builder: (context, participants) {
                      return Checkbox(
                          value: participants.contains(person),
                          onChanged: (newValue) {
                            widget.sharedExpense.changeParticipantState(
                                person, newValue ?? false);
                            updateState();
                          });
                    })
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  widget.onRemove();
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Remove",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
              const Expanded(child: SizedBox()),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  icon: const Icon(Icons.check))
            ],
          )
        ],
      ),
    );
  }
}
