
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/cupertino.dart';

String oldMainName = "";

dynamic buildPageWithDefaultTransition<T>({
  required BuildContext context, 
  required GoRouterState state, 
  required Widget child,
}) {
  
  bool isAnimation = state.name == oldMainName;
  oldMainName = state.name ?? "";

  if (isAnimation) { 
    return MaterialPage<void>(
      key: state.pageKey,
      restorationId: state.pageKey.value,
      child: child,
    );
    // return CustomTransitionPage<T>(
    //   key: state.pageKey,
    //   // transitionDuration: const Duration(milliseconds: 100),
    //   child: child,
    //   transitionsBuilder: (context, animation, secondaryAnimation, child) =>
    //     // FadeTransition(opacity: animation, child: child),
    //     CupertinoPageTransition(primaryRouteAnimation: animation, secondaryRouteAnimation: secondaryAnimation, child: child, linearTransition: false)
    // );
  }
  else {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      transitionDuration: const Duration(milliseconds: 100),
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
    );
  }
}