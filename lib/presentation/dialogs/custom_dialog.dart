import 'package:billsplit_flutter/presentation/common/simple_button.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String text;
  final String? primaryText;
  final String? secondaryText;
  final Function() onPrimaryClick;
  final Function()? onSecondaryClick;

  const CustomDialog({
    required this.text,
    required this.onPrimaryClick,
    required this.primaryText,
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
              Text(text),
              const SizedBox(height: 16),
              SimpleButton(
                  color: Theme.of(context).colorScheme.primary,
                  onClick: onPrimaryClick,
                  child: Text(
                    primaryText ?? "OK",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                  )),
              if (secondaryText != null) const SizedBox(height: 8),
              if (secondaryText != null)
                SimpleButton(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  onClick: () {
                    onSecondaryClick?.call();
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
