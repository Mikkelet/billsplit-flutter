import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ExtendedFloatingActionButton extends StatefulWidget {
  final ScrollController scrollController;
  final String label;
  final IconData icon;
  final Function() onPressed;

  const ExtendedFloatingActionButton(
      {Key? key,
      required this.scrollController,
      required this.label,
      required this.icon,
      required this.onPressed})
      : super(key: key);

  @override
  State<ExtendedFloatingActionButton> createState() =>
      _ExtendedFloatingActionButtonState();
}

class _ExtendedFloatingActionButtonState
    extends State<ExtendedFloatingActionButton> {
  bool isExtended = true;

  @override
  void initState() {
    widget.scrollController.addListener(() {
      final newState = widget.scrollController.position.pixels < 100;
      if (newState != isExtended) {
        setState(() {
          isExtended = newState;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      isExtended: isExtended,
      key: UniqueKey(),
      onPressed: widget.onPressed,
      backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
      icon: Icon(widget.icon),
      label: Text(widget.label),
    );
  }
}
