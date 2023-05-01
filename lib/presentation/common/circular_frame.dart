import 'package:flutter/material.dart';

class CircularFrame extends StatelessWidget {
  final bool show;
  final Widget child;

  const CircularFrame({Key? key, required this.child, this.show = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(!show) return child;
    return ClipOval(
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(2),
        ),
        child: child,
      ),
    );
  }
}
