import 'package:flutter/material.dart';

class DialogWithCloseButton extends StatelessWidget {
  final Widget child;
  final String title;

  const DialogWithCloseButton({Key? key, required this.child, this.title = ""})
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
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: Text(title, style: Theme.of(context).textTheme.labelLarge,)),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    visualDensity: VisualDensity.compact,
                    color: Theme.of(context).colorScheme.onBackground,
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            child
          ],
        ),
      ),
    );
  }
}
