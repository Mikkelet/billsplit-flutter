import 'package:billsplit_flutter/presentation/common/rounded_list_item.dart';
import 'package:flutter/material.dart';

class EditNameDialog extends StatefulWidget {
  final String initState;
  final Function(String) onSubmit;

  const EditNameDialog({super.key, required this.initState, required this.onSubmit});

  @override
  State<EditNameDialog> createState() => _EditNameDialogState();
}

class _EditNameDialogState extends State<EditNameDialog> {
  late final _textEditingController =
      TextEditingController(text: widget.initState);

  @override
  Widget build(BuildContext context) {
    return RoundedListItem(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textEditingController,
              autofocus: true,
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.labelLarge?.fontSize),
              decoration: const InputDecoration(
                border: InputBorder.none,
                counterText: "",
              ),
              maxLines: 1,
              onChanged: (val) {
                _textEditingController.text = val;
              },
            ),
          ),
          IconButton(
            onPressed: () {
              widget.onSubmit(_textEditingController.text);
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.check),
          )

        ],
      ),
    );
  }
}
