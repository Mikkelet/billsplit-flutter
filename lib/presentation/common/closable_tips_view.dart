import 'package:billsplit_flutter/utils/safe_stateful_widget.dart';
import 'package:flutter/material.dart';

class ClosableTipView extends StatefulWidget {
  final String tip;
  final EdgeInsets padding;
  final bool hasSeen;
  final Function() onClose;

  const ClosableTipView(
      {Key? key,
      required this.tip,
      this.padding = EdgeInsets.zero,
      required this.hasSeen,
      required this.onClose})
      : super(key: key);

  @override
  State<ClosableTipView> createState() => _ClosableTipViewState();
}

class _ClosableTipViewState extends SafeState<ClosableTipView> {
  late bool hasSeen = widget.hasSeen;

  @override
  Widget build(BuildContext context) {
    if (hasSeen) return const SizedBox();
    return Padding(
      padding: widget.padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              "Tip: long press a user to quick-add an expense for them",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey),
            ),
          ),
          IconButton(
            onPressed: () {
              widget.onClose();
              setState(() {
                hasSeen = true;
              });
            },
            icon: const Icon(Icons.close_outlined),
            visualDensity: VisualDensity.compact,
          )
        ],
      ),
    );
  }
}
