import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:billsplit_flutter/presentation/dialogs/participant_picker/temporary_participant_view.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:flutter/material.dart';

class ParticipantsPickerDialog extends StatefulWidget {
  final List<Person> participants;
  final Iterable<Person> people;
  final Widget? extraAction;
  final bool showSubmit;
  final Function(String)? onAddTempParticipant;

  const ParticipantsPickerDialog({
    super.key,
    required this.participants,
    required this.people,
    this.onAddTempParticipant,
    this.extraAction,
    this.showSubmit = true,
  });

  @override
  State<ParticipantsPickerDialog> createState() =>
      _ParticipantsPickerDialogState();
}

class _ParticipantsPickerDialogState
    extends SafeState<ParticipantsPickerDialog> {
  void changeParticipantStatus(Person person, bool isParticipant) {
    if (isParticipant) {
      widget.participants.add(person);
    } else {
      widget.participants.remove(person);
    }
  }

  bool _isEveryoneSelected() =>
      widget.people.length == widget.participants.length;

  bool _showMin1PersonError = false;

  @override
  Widget build(BuildContext context) {
    final allowTempParticipants = widget.onAddTempParticipant != null;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _appBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 4),
              ...widget.people.map(
                    (person) => _participantView(person),
              ),
              if (allowTempParticipants) const SizedBox(height: 8),
              if (allowTempParticipants)
                TemporaryParticipantView(
                  onAddTempParticipant: widget.onAddTempParticipant,
                ),
              const SizedBox(height: 8),
              if (_showMin1PersonError)
                Text(
                  "Must include at least one person",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.error),
                ),
              if (widget.extraAction != null) const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [if (widget.extraAction != null) widget.extraAction!],
              ),
            ],
          ),
        ),
      )
    );
  }

  AppBar _appBar(){
    return AppBar(
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0 ,
      actions: [
        if (widget.showSubmit)
          IconButton(
            onPressed: () {
              Navigator.of(context).pop(widget.participants);
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
                  widget.participants.clear();
                  widget.participants.addAll(widget.people);
                  updateState();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _participantView(Person person) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              widget.participants.clear();
              widget.participants.add(person);
              updateState();
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
          value: widget.participants.contains(person),
          onChanged: (isParticipant) {
            if (isParticipant == false && widget.participants.length == 1) {
              // cannot have 0 participants
              _showMin1PersonError = true;
            } else {
              _showMin1PersonError = false;
              changeParticipantStatus(person, isParticipant ?? false);
            }
            updateState();
          },
        )
      ],
    );
  }
}
