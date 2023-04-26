import 'package:flutter/material.dart';

class RoundedListItem extends StatelessWidget {
  final Widget child;
  final Color? color;
  final BorderRadius? borderRadius;

  const RoundedListItem(
      {Key? key, required this.child, this.color, this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: color ?? Theme.of(context).colorScheme.primaryContainer,
          borderRadius: borderRadius ?? BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}
