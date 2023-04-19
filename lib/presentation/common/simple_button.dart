import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  final Function() onClick;
  final Widget child;

  const SimpleButton(
      {super.key, required this.onClick, required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onClick,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      color: Theme.of(context).colorScheme.secondary,
      elevation: 0,
      highlightElevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
        child: child,
      ),
    );
  }
}
