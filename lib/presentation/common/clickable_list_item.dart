import 'package:flutter/material.dart';

class ClickableListItem extends StatelessWidget {
  final Function() onClick;
  final Widget child;
  final Color? color;
  final EdgeInsets? padding;
  final Alignment? alignment;
  final BorderRadius? borderRadius;
  final double cornerRadius;
  final double elevation;

  final bool enabled;

  const ClickableListItem(
      {super.key,
      required this.onClick,
      required this.child,
      this.enabled = true,
      this.color,
      this.padding,
      this.alignment,
      this.borderRadius,
      this.cornerRadius = 30,
      this.elevation = 0});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(cornerRadius)),
      elevation: elevation,
      surfaceTintColor: color ?? Theme.of(context).colorScheme.primaryContainer,
      color: color ?? Theme.of(context).colorScheme.primaryContainer,
      child: InkWell(

      borderRadius: borderRadius ?? BorderRadius.circular(cornerRadius),
        onTap: enabled ? onClick : null,
        child: Padding(
          padding: padding ??
              const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Align(alignment: alignment ?? Alignment.center, child: child),
        ),
      ),
    );
  }
}
/**
 *
 */
