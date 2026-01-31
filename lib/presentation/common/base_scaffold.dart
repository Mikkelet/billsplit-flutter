import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final Widget? body;
  final PreferredSizeWidget? appBar;
  final Widget? endDrawer;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Function(bool changed)? onEndDrawerStateChanged;

  const BaseScaffold({
    super.key,
    this.body,
    this.appBar,
    this.endDrawer,
    this.floatingActionButtonAnimator,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.floatingActionButtonLocation,
    this.onEndDrawerStateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      endDrawer: endDrawer,
      floatingActionButton: floatingActionButton,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
      body: body,
    );
  }
}