import 'package:billsplit_flutter/domain/models/person.dart';
import 'package:billsplit_flutter/presentation/common/clickable_list_item.dart';
import 'package:billsplit_flutter/presentation/common/pfp_view.dart';
import 'package:flutter/material.dart';

class TemporaryParticipantView extends StatefulWidget {
  final Function(String)? onAddTempParticipant;

  const TemporaryParticipantView({super.key, this.onAddTempParticipant});

  @override
  State<TemporaryParticipantView> createState() =>
      _TemporaryParticipantViewState();
}

class _TemporaryParticipantViewState extends State<TemporaryParticipantView> {
  final _textEditingController = TextEditingController();

  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    if (!isEditing) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: ClickableListItem(
              height: 48,
              width: 48,
              color: Theme.of(context).colorScheme.secondaryContainer,
              onClick: () {
                setState(() {
                  isEditing = true;
                });
              },
              child: const Icon(Icons.person_add_alt_1),
            ),
          ),
        ],
      );
    }
    return Row(
      children: [
        ProfilePictureView(person: Person(uid: "", name: "")),
        const SizedBox(width: 8),
        Flexible(
          child: TextField(
            controller: _textEditingController,
            textInputAction: TextInputAction.done,
            autofocus: true,
            onSubmitted: (name) {
              widget.onAddTempParticipant?.call(name);
              _textEditingController.clear();
              setState(() {
                isEditing = false;
              });
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Enter a name for a temporary person",
              hintStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
