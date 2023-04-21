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
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SimpleButton(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      onClick: onPrimaryClick,
                      child: Text(primaryText ?? "OK")),
                  Visibility(
                    visible: secondaryText != null,
                    child: SimpleButton(
                        onClick: () {
                          if(onSecondaryClick != null) {
                            print("qqq call!");
                            onSecondaryClick?.call();
                          }
                        },
                        child: Text("$secondaryText")),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
