import 'package:flutter/material.dart';

class UpdatableTextField extends StatefulWidget {
  final String initState;
  final bool isUpdating;
  final bool isEditing;
  final Function() onUpdateClicked;
  final Function() onEditPressed;
  final Function() onCancelPressed;
  final Function(String) onChange;

  const UpdatableTextField(
      {Key? key,
      required this.initState,
      required this.onUpdateClicked,
      required this.isUpdating,
      required this.isEditing,
      required this.onEditPressed,
      required this.onCancelPressed,
      required this.onChange})
      : super(key: key);

  @override
  State<UpdatableTextField> createState() => _UpdatableTextField();
}

class _UpdatableTextField extends State<UpdatableTextField> {
  late String currentState = widget.initState;
  late final controller = TextEditingController(text: currentState);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (!widget.isEditing && !widget.isUpdating) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                currentState,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              IconButton(
                onPressed: () {
                  widget.onEditPressed();
                },
                icon: const Icon(Icons.edit),
                color: Theme.of(context).colorScheme.secondary,
              )
            ],
          );
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: TextField(
                autofocus: true,
                decoration: const InputDecoration(
                    border: InputBorder.none, counterText: ""),
                maxLines: 1,
                maxLength: 20,
                controller: controller,
                onChanged: (val) {
                  currentState = val;
                  widget.onChange(val);
                },
              ),
            ),
            if (widget.isUpdating)
              const CircularProgressIndicator()
            else ...[
              IconButton(
                onPressed: () {
                  widget.onUpdateClicked();
                },
                icon: const Icon(Icons.check),
                color: Colors.green,
              ),
              IconButton(
                onPressed: () {
                  widget.onCancelPressed();
                },
                icon: const Icon(Icons.close),
                color: Colors.red,
              ),
            ]
          ],
        );
      },
    );
  }
}
