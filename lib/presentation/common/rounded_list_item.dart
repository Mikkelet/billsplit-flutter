import 'package:flutter/material.dart';

class RoundedListItem extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;

  const RoundedListItem({Key? key, required this.child, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}
