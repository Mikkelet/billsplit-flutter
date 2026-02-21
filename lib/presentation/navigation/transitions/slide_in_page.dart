import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:go_router/go_router.dart';

// ignore: non_constant_identifier_names
Page<void> SlideInTransition({
  required GoRouterState state,
  required Widget child,
  bool withEnterAnimation = true,
  bool withExitAnimation = true,
}) {
  if (Platform.isIOS) {
    return cupertino.CupertinoPage<void>(
      key: state.pageKey,
      child: child,
    );
  }
  return CustomTransitionPage(
    key: state.pageKey,
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    child: child,
    transitionsBuilder: (context, enterAnimation, exitAnimation, child) {
      final curvedEnterAnimation = CurvedAnimation(
        parent: enterAnimation,
        curve: Curves.easeInOutCubic,
      );
      final curvedExitAnimation = CurvedAnimation(
        parent: exitAnimation,
        curve: Curves.easeInOutCubic,
      );

      Widget result = child;

      // Exit animation (when a new page is pushed on top of this one)
      if (withExitAnimation) {
        result = SlideTransition(
          position: Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(-1.0, 0.0),
          ).animate(curvedExitAnimation),
          child: result,
        );
      }

      // Enter animation (when this page enters or when going back from this page)
      if (withEnterAnimation) {
        result = SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(curvedEnterAnimation),
          child: result,
        );
      } else {
        // Only animate when going back (reverse), not when entering (forward)
        result = AnimatedBuilder(
          animation: enterAnimation,
          builder: (context, animatedChild) {
            if (enterAnimation.status == AnimationStatus.reverse) {
              final offset = Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).evaluate(curvedEnterAnimation);
              return FractionalTranslation(
                translation: offset,
                child: animatedChild,
              );
            }
            return animatedChild!;
          },
          child: result,
        );
      }

      return result;
    },
  );
}
