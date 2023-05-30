import 'package:billsplit_flutter/presentation/themes/splitsby_text_theme.dart';
import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:flutter/material.dart';

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
    extends SafeState<ExtendedFloatingActionButton> {
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
      extendedTextStyle: SplitsbyTextTheme.fabText(context),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      onPressed: widget.onPressed,
      icon: Icon(widget.icon),
      label: Text(widget.label),
    );
  }
}
