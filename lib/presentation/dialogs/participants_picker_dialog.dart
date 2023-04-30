import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:flutter/material.dart';

class ParticipantsPickerDialog extends StatefulWidget {
  final List<Person> participants;
  final Iterable<Person> people;
  final Widget? extraAction;
  final bool showSubmit;

  const ParticipantsPickerDialog({
    Key? key,
    required this.participants,
    required this.people,
    this.extraAction,
    this.showSubmit = true,
  }) : super(key: key);

  @override
  State<ParticipantsPickerDialog> createState() =>
      _ParticipantsPickerDialogState();
}

class _ParticipantsPickerDialogState extends State<ParticipantsPickerDialog> {
  void changeParticipantStatus(Person person, bool isParticipant) {
    if (isParticipant) {
      widget.participants.add(person);
    } else {
      widget.participants.remove(person);
    }
  }

  bool _isEveryoneSelected() =>
      widget.people.length == widget.participants.length;

  bool showMin1PersonError = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 4),
        if (widget.people.length >= 3)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  "tip: tap a friend's name to select only them!",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Theme.of(context).disabledColor),
                ),
              ),
              Checkbox(
                tristate: true,
                value: (_isEveryoneSelected()) ? true : null,
                onChanged: _isEveryoneSelected()
                    ? null
                    : (value) {
                        if (value == false) {
                          widget.participants.clear();
                          widget.participants.addAll(widget.people);
                          setState(() {});
                        }
                      },
              )
            ],
          ),
        const SizedBox(height: 4),
        ...widget.people.map(
          (person) => Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    widget.participants.clear();
                    widget.participants.add(person);
                    setState(() {});
                  },
                  child: Row(
                    children: [
                      ProfilePictureView(person: person),
                      const SizedBox(width: 16),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(person.nameState)),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 32),
              Checkbox(
                  value: widget.participants.contains(person),
                  onChanged: (isParticipant) {
                    if (isParticipant == false &&
                        widget.participants.length == 1) {
                      // cannot have 0 participants
                      showMin1PersonError = true;
                    } else {
                      showMin1PersonError = false;
                      changeParticipantStatus(person, isParticipant ?? false);
                    }
                    setState(() {});
                  })
            ],
          ),
        ),
        const SizedBox(height: 8),
        if (showMin1PersonError)
          Text(
            "Must include at least one person",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).colorScheme.error),
          ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.extraAction != null)
              widget.extraAction!
            else
              const SizedBox(),
            if (widget.showSubmit)
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop(widget.participants);
                },
                disabledColor: Theme.of(context).disabledColor,
                color: Theme.of(context).colorScheme.primary,
                icon: const Icon(Icons.check),
              )
          ],
        )
      ],
    );
  }
}
