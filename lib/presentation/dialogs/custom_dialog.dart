import 'package:billsplit_flutter/presentation/common/simple_button.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String? title;
  final String? text;
  final String? primaryText;
  final String? secondaryText;
  final Function()? onPrimaryClick;
  final Function()? onSecondaryClick;

  const CustomDialog({
    this.title,
    this.text,
    this.onPrimaryClick,
    this.primaryText,
    this.onSecondaryClick,
    this.secondaryText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title ?? "",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 16),
              Text(
                text ?? "",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              SimpleButton(
                  onClick: onPrimaryClick ??
                      () {
                        Navigator.of(context).pop(true);
                      },
                  child: Text(
                    primaryText ?? "OK",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary),
                  )),
              if (secondaryText != null) const SizedBox(height: 8),
              if (secondaryText != null)
                TextButton(
                  onPressed: () {
                    onSecondaryClick?.call() ??
                        Navigator.of(context).pop(false);
                  },
                  child: Text(
                    "$secondaryText",
                    style: TextStyle(
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
