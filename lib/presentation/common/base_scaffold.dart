import 'package:billsplit_flutter/presentation/common/gradient_background.dart';
import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final Widget? body;
  final PreferredSizeWidget? appBar;
  final Widget? endDrawer;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  const BaseScaffold(
      {super.key,
      this.body,
      this.appBar,
      this.endDrawer,
      this.floatingActionButtonAnimator,
      this.floatingActionButton,
      this.bottomNavigationBar,
      this.floatingActionButtonLocation});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar,
        endDrawer: endDrawer,
        floatingActionButton: floatingActionButton,
        floatingActionButtonAnimator: floatingActionButtonAnimator,
        floatingActionButtonLocation: floatingActionButtonLocation,
        bottomNavigationBar: bottomNavigationBar,
        body: body,
      ),
    );
  }
}
