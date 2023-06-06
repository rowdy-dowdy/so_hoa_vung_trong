import 'package:flutter/material.dart';

class CustomCupertinoPageRoute<T> extends PageRoute<T> {
  final WidgetBuilder builder;
  final bool maintainState;
  final bool fullscreenDialog;

  CustomCupertinoPageRoute({required this.builder,this.maintainState = true,
    this.fullscreenDialog = false, super.settings});

  @override
  bool get opaque => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String? get barrierLabel => null;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 400);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween(begin: Offset(1.0, 0.0), end: Offset.zero)
          .animate(animation),
      child: CupertinoPageTransition(
        primaryRouteAnimation: animation,
        secondaryRouteAnimation: secondaryAnimation,
        linearTransition: true,
        child: child,
      ),
    );
  }
}

class CupertinoPageTransition extends StatelessWidget {
  final Animation<double> primaryRouteAnimation;
  final Animation<double> secondaryRouteAnimation;
  final bool linearTransition;
  final Widget child;

  const CupertinoPageTransition({required this.primaryRouteAnimation,
    required this.secondaryRouteAnimation,
    required this.linearTransition,
    required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return new SlideTransition(
      position: new Tween<Offset>(
        begin: const Offset(0.0, 0.0),
        end: const Offset(-1.0, 0.0),
      ).animate(linearTransition
          ? primaryRouteAnimation
          : CurvedAnimation(
              parent: primaryRouteAnimation,
              curve: Curves.easeOut,
              reverseCurve: Curves.easeIn,
            )),
      child: new SlideTransition(
        position: new Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(linearTransition
            ? secondaryRouteAnimation
            : CurvedAnimation(
                parent: secondaryRouteAnimation,
                curve: Curves.easeOut,
                reverseCurve: Curves.easeIn,
              )),
        child: child,
      ),
    );
  }
}