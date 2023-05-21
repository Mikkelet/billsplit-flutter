import 'package:flutter/material.dart';

class ClickableListItem extends StatelessWidget {
  final Function() onClick;
  final Widget child;
  final Color? color;
  final EdgeInsets? padding;
  final Alignment? alignment;
  final BorderRadius? borderRadius;
  final double cornerRadius;

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
      this.cornerRadius = 30});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(cornerRadius)),
        elevation: 0,
        color: color,
      child: InkWell(
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
