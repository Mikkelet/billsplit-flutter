import 'package:flutter/material.dart';

class ClosableTipView extends StatefulWidget {
  final String tip;
  final EdgeInsets padding;

  const ClosableTipView(
      {Key? key, required this.tip, this.padding = EdgeInsets.zero})
      : super(key: key);

  @override
  State<ClosableTipView> createState() => _ClosableTipViewState();
}

class _ClosableTipViewState extends State<ClosableTipView> {
  bool showTip = true;

  @override
  Widget build(BuildContext context) {
    if (showTip == false) return const SizedBox();
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
              setState(() {
                showTip = false;
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
