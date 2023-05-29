import 'package:flutter/cupertino.dart';

abstract class SafeState<T extends StatefulWidget> extends State<T> {
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void updateState() {
    setState(() {});
  }
}
