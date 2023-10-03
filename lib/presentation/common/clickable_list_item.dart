import 'package:flutter/material.dart';

class ClickableListItem extends StatelessWidget {
  final VoidCallback onClick;
  final Widget child;
  final Color? color;
  final EdgeInsets padding;
  final Alignment alignment;
  final BorderRadius? borderRadius;
  final double cornerRadius;
  final double elevation;
  final double? height;
  final double? width;

  final bool enabled;

  const ClickableListItem(
      {super.key,
      required this.onClick,
      required this.child,
      this.enabled = true,
      this.color,
      this.height,
      this.width,
      this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      this.alignment = Alignment.center,
      this.cornerRadius = 10,
      this.borderRadius,
      this.elevation = 0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(cornerRadius)),
        elevation: elevation,
        color: color ?? Theme.of(context).colorScheme.primaryContainer,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: enabled ? onClick : null,
          child: Padding(
            padding: padding,
            child: Align(
              alignment: alignment,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
