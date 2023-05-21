import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum UpdateTextFieldState { isUpdating, isEditing, display }

class UpdatableTextField extends StatefulWidget {
  final String initState;
  final UpdateTextFieldState state;
  final Function(String) onUpdateClicked;
  final Function() onEditPressed;
  final Function() onCancelPressed;
  final int charLimit;

  const UpdatableTextField(
      {Key? key,
      required this.initState,
      required this.onUpdateClicked,
      required this.onEditPressed,
      required this.onCancelPressed,
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
              Flexible(
                child: Text(
                  currentState,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                child: IconButton(
                  onPressed: () {
                    HapticFeedback.heavyImpact();
                    widget.onEditPressed();
                  },
                  icon: const Icon(Icons.edit),
                  color: Theme.of(context).colorScheme.onSurface,
                ),
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
                },
              ),
            ),
            if (isLoading)
              const CircularProgressIndicator()
            else ...[
              IconButton(
                onPressed: () {
                  if (currentState != widget.initState) {
                    widget.onUpdateClicked(controller.text);
                  } else {
                    widget.onCancelPressed();
                  }
                },
                icon: const Icon(Icons.check),
                color: Colors.green,
              ),
              IconButton(
                onPressed: () {
                  currentState = widget.initState;
                  controller.text = widget.initState;
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
