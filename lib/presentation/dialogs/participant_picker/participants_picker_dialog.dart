import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:billsplit_flutter/presentation/dialogs/participant_picker/temporary_participant_view.dart';
import 'package:billsplit_flutter/presentation/mutable_state.dart';
import 'package:flutter/material.dart';

class ParticipantsPickerDialog extends StatelessWidget {
  final MutableListState<Person> participants;
  final Iterable<Person> people;
  final Widget? extraAction;
  final bool showSubmit;
  final Function(String)? onAddTempParticipant;
  final _showMin1PersonError = false;

  const ParticipantsPickerDialog({
    super.key,
    required this.participants,
    required this.people,
    this.showSubmit = true,
    this.onAddTempParticipant,
    this.extraAction,
  });

  void changeParticipantStatus(Person person, bool isParticipant) {
    if (isParticipant) {
      participants.add(person);
    } else {
      participants.remove(person);
    }
  }

  bool _isEveryoneSelected() =>
      people.length == participants.value.length;


  @override
  Widget build(BuildContext context) {
    final allowTempParticipants = onAddTempParticipant != null;
    return MutableValue(
        mutableValue: participants,
        builder: (context, participants) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: _appBar(context),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 4),
                    ...people.map(
                      (person) => _participantView(context, person),
                    ),
                    if (allowTempParticipants) const SizedBox(height: 8),
                    if (allowTempParticipants)
                      TemporaryParticipantView(
                        onAddTempParticipant: onAddTempParticipant,
                      ),
                    const SizedBox(height: 8),
                    if (_showMin1PersonError)
                      Text(
                        "Must include at least one person",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.error),
                      ),
                    if (extraAction != null) const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (extraAction != null) extraAction!
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
      actions: [
        if (showSubmit)
          IconButton(
            onPressed: () {
              Navigator.of(context).pop(participants);
            },
            disabledColor: Theme.of(context).disabledColor,
            color: Theme.of(context).colorScheme.onBackground,
            icon: const Icon(Icons.check),
          )
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                "tip: tap a friend to select only them!",
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
            ),
            Checkbox(
              fillColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.disabled)) {
                  return Theme.of(context).colorScheme.inversePrimary;
                }
                return Theme.of(context).colorScheme.secondaryContainer;
              }),
              tristate: true,
              value: (_isEveryoneSelected()) ? true : null,
              onChanged: _isEveryoneSelected()
                  ? null
                  : (value) {
                      if (value == false) {
                        participants.clear();
                        participants.addAll(people);
                      }
                    },
            ),
          ],
        ),
      ),
    );
  }

  Widget _participantView(BuildContext context, Person person) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              participants.clear();
              participants.add(person);
            },
            child: Row(
              children: [
                ProfilePictureView(person: person),
                const SizedBox(width: 8),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      person.displayName,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.labelLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 32),
        Checkbox(
          fillColor: MaterialStateProperty.resolveWith((states) {
            return Theme.of(context).colorScheme.secondaryContainer;
          }),
          value: participants.value.contains(person),
          onChanged: (isParticipant) {
            if (isParticipant == false &&
                participants.value.length == 1) {
              // cannot have 0 participants
            } else {
              changeParticipantStatus(person, isParticipant ?? false);
            }
          },
        )
      ],
    );
  }
}
