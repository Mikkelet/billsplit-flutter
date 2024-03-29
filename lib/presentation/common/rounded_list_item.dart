import 'package:flutter/material.dart';

class RoundedListItem extends StatelessWidget {
  final Widget child;
  final Color? color;
    final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final Alignment? align;

  const RoundedListItem(
      {super.key,
      required this.child,
      this.color,
      this.width,
      this.height,
      this.align,
      this.borderRadius,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      alignment: align ?? Alignment.center,
      decoration: BoxDecoration(
          color: color ?? Theme.of(context).colorScheme.primaryContainer,
          borderRadius: borderRadius ?? BorderRadius.circular(15)),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}
