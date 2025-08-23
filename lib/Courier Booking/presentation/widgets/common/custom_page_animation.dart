import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage<T> buildCustomTransitionPage<T>({
  required GoRouterState state,
  required Widget child,
  Duration duration = const Duration(milliseconds: 500),
  Curve curve = Curves.linear,
  Offset beginOffset = const Offset(1, 0),
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    transitionDuration: duration,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final tween = Tween<Offset>(
        begin: beginOffset,
        end: Offset.zero,
      ).chain(CurveTween(curve: curve));
      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}
