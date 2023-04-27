import 'package:flutter/material.dart';

class DialogWithCloseButton extends StatelessWidget {
  final Widget child;

  const DialogWithCloseButton({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16, top: 16),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: Theme.of(context).colorScheme.primary,
                icon: const Icon(Icons.close),
              ),
            ),
            child
          ],
        ),
      ),
    );
  }
}
