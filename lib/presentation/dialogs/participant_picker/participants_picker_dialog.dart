import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:billsplit_flutter/presentation/dialogs/participant_picker/temporary_participant_view.dart';
import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
import 'package:billsplit_flutter/utils/utils.dart';
import 'package:flutter/material.dart';

class ParticipantsPickerDialog extends StatelessWidget {
  final List<Person> participants;
  final List<Person> people;
  final List<Person> initialParticipantState;
  final List<Person> initialpeople;
  final num totalExpense;
  final String currencySymbol;
  final Widget? extraAction;
  final String description;
  final bool showSubmit;
  final Function(String)? onAddTempParticipant;

  const ParticipantsPickerDialog({
    super.key,
    required this.participants,
    required this.people,
    required this.totalExpense,
    required this.currencySymbol,
    required this.description,
    this.showSubmit = true,
    this.onAddTempParticipant,
    this.extraAction,
  })  : initialParticipantState = participants,
        initialpeople = people;

  final _showMin1PersonError = false;

  void changeParticipantStatus(Person person, bool isParticipant) {
    if (isParticipant) {
      participants.add(person);
    } else {
      participants.remove(person);
    }
  }

  bool _isEveryoneSelected(int peopleSize) =>
      peopleSize == participants.length;

  @override
  Widget build(BuildContext context) {
    final allowTempParticipants = onAddTempParticipant != null;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: _appBar(context, people),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
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
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                      color: Theme.of(context).colorScheme.error),
                ),
              if (extraAction != null) const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [if (extraAction != null) extraAction!],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context, Iterable<Person> people) {
    return AppBar(
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
      title: Text(description),
      leading: IconButton(
        onPressed: () async {
          // show the change-back animation before popping,
          // so the user can see they discarded their changes
          final shouldWait =
              participants != initialParticipantState ||
                  people != initialpeople;
          people = initialpeople;
          if (shouldWait) {
            await Future.delayed(const Duration(milliseconds: 500));
          }
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        },
        color: Theme.of(context).colorScheme.error,
        icon: const Icon(Icons.close),
      ),
      actions: [
        if (showSubmit)
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            disabledColor: Theme.of(context).disabledColor,
            color: Theme.of(context).colorScheme.onSurface,
            icon: const Icon(Icons.check),
          )
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                fillColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.disabled)) {
                    return Theme.of(context).colorScheme.inversePrimary;
                  }
                  return Theme.of(context).colorScheme.secondaryContainer;
                }),
                tristate: true,
                value: (_isEveryoneSelected(people.length)) ? true : null,
                onChanged: _isEveryoneSelected(people.length)
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
      ),
    );
  }

  Widget _participantView(BuildContext context, Person person) {
    num amount = 0;
    final isTemp = person.uid.startsWith("temp");
    final isParticipant = participants.contains(person);
    if (totalExpense > 0 && isParticipant) {
      amount = totalExpense / participants.length;
    }
    return Column(
      children: [
        Row(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              person.displayName,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.titleSmall,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                Text(
                                  currencySymbol,
                                  style:
                                      SplitsbyTextTheme.groupViewDebtCurrency(
                                          context),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  amount.fmt2dec(),
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (isTemp) _tempSettings(context),
            const SizedBox(width: 8),
            Checkbox(
              fillColor: WidgetStateProperty.resolveWith((states) {
                return Theme.of(context).colorScheme.secondaryContainer;
              }),
              value: participants.contains(person),
              onChanged: (isParticipant) {
                if (isParticipant == false &&
                    participants.length == 1) {
                  // cannot have 0 participants
                } else {
                  changeParticipantStatus(person, isParticipant ?? false);
                }
              },
            )
          ],
        ),
        const SizedBox(height: 16)
      ],
    );
  }

  Widget _tempSettings(BuildContext context) {
    return const SizedBox(); // Disabled until I figure out a way to handle this. See Trello#146
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Scaffold(
                body: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                          onPressed: () {}, child: const Text("Edit name")),
                      TextButton(
                          onPressed: () {},
                          child: const Text("Delete temp user"))
                    ],
                  ),
                ),
              );
            });
      },
      icon: const Icon(
        Icons.settings,
        size: 15,
      ),
      color: Theme.of(context).colorScheme.onSurface,
    );
  }
}
