import 'package:flutter/material.dart';

enum UpdateTextFieldState { isUpdating, isEditing, display }

class UpdatableTextField extends StatefulWidget {
  final String initState;
  final UpdateTextFieldState state;
  final Function() onUpdateClicked;
  final Function() onEditPressed;
  final Function() onCancelPressed;
  final Function(String) onChange;
  final int charLimit;

  const UpdatableTextField(
      {Key? key,
      required this.initState,
      required this.onUpdateClicked,
      required this.onEditPressed,
      required this.onCancelPressed,
      required this.onChange,
      this.charLimit = 40,
      required this.state})
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
    final showDisplay = widget.state == UpdateTextFieldState.display;
    final isLoading = widget.state == UpdateTextFieldState.isUpdating;
    return Builder(
      builder: (context) {
        if (showDisplay) {
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
                  border: InputBorder.none,
                  counterText: "",
                ),
                maxLines: 1,
                maxLength: widget.charLimit,
                controller: controller,
                onChanged: (val) {
                  currentState = val;
                  widget.onChange(val);
                },
              ),
            ),
            if (isLoading)
              const CircularProgressIndicator()
            else ...[
              IconButton(
                onPressed: () {
                  if (currentState != widget.initState) {
                    widget.onUpdateClicked();
                  } else {
                    widget.onCancelPressed();
                  }
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
