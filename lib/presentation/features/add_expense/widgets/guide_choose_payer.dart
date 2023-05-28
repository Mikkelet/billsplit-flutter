import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GuideView extends StatefulWidget {
  final BorderRadius? borderRadius;
  final String text;
  final Function() onClick;
  final bool show;

  const GuideView(
      {Key? key,
      this.borderRadius,
      required this.text,
      required this.onClick,
      required this.show})
      : super(key: key);

  @override
  State<GuideView> createState() => _GuideViewState();
}

class _GuideViewState extends State<GuideView> {
  late bool show = widget.show;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: show,
      child: InkWell(
        onTap: () {
          setState(() {
            widget.onClick();
            show = false;
          });
        },
        child: Opacity(
          opacity: 0.95,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: widget.borderRadius ?? BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const Icon(Icons.check),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ).animate(delay: 1.seconds).fadeIn(duration: 1.seconds);
  }
}
