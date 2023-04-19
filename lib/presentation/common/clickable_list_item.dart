import 'package:flutter/material.dart';

class ClickableListItem extends StatelessWidget {
  final Function() onClick;
  final Widget child;
  final Color? color;
  final EdgeInsets? padding;

  const ClickableListItem(
      {super.key,
      required this.onClick,
      required this.child,
      this.color,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onClick,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      color: color ?? Theme.of(context).colorScheme.primaryContainer,
      elevation: 0,
      highlightElevation: 0,
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
        child: child,
      ),
    );
  }
}
