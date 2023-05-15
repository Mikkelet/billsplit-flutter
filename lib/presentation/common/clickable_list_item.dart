import 'package:flutter/material.dart';

class ClickableListItem extends StatelessWidget {
  final Function() onClick;
  final Widget child;
  final Color? color;
  final EdgeInsets? padding;
  final Alignment? alignment;
  final bool enabled;

  const ClickableListItem(
      {super.key,
      required this.onClick,
      required this.child,
      this.enabled = true,
      this.color,
      this.padding,
      this.alignment});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: enabled ? onClick : null,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      color: color ?? Theme.of(context).colorScheme.primaryContainer,
      elevation: 0,
      highlightElevation: 0,
      disabledColor: Theme.of(context).disabledColor.withAlpha(50),
      child: Padding(
        padding:
            padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
        child: Align(alignment: alignment ?? Alignment.center, child: child),
      ),
    );
  }
}
