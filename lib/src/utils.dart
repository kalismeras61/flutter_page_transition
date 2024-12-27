// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:page_transition/src/page_transition.dart';
import 'package:page_transition/src/enum.dart';

class Transitions {
  static slideTransition(animation, child) => SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
}

extension PageTransitionExtension on BuildContext {
  Future<T?> pushTransition<T>({
    Widget? child,
    ChildBuilder? childBuilder,
    required PageTransitionType type,
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.linear,
    bool fullscreenDialog = false,
    bool opaque = false,
    RouteSettings? settings,
  }) {
    return Navigator.push<T>(
      this,
      PageTransition(
        type: type,
        child: child,
        childBuilder: childBuilder,
        duration: duration,
        curve: curve,
        fullscreenDialog: fullscreenDialog,
        opaque: opaque,
        settings: settings,
      ),
    );
  }

  Future<T?> pushReplacementTransition<T, TO>({
    Widget? child,
    ChildBuilder? childBuilder,
    required PageTransitionType type,
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.linear,
    bool fullscreenDialog = false,
    bool opaque = false,
    RouteSettings? settings,
    TO? result,
  }) {
    return Navigator.pushReplacement<T, TO>(
      this,
      PageTransition(
        type: type,
        child: child,
        childBuilder: childBuilder,
        duration: duration,
        curve: curve,
        fullscreenDialog: fullscreenDialog,
        opaque: opaque,
        settings: settings,
      ),
      result: result,
    );
  }

  Future<T?> pushAndRemoveUntilTransition<T>({
    Widget? child,
    ChildBuilder? childBuilder,
    required PageTransitionType type,
    required RoutePredicate predicate,
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.linear,
    bool fullscreenDialog = false,
    bool opaque = false,
    RouteSettings? settings,
  }) {
    return Navigator.pushAndRemoveUntil<T>(
      this,
      PageTransition(
        type: type,
        child: child,
        childBuilder: childBuilder,
        duration: duration,
        curve: curve,
        fullscreenDialog: fullscreenDialog,
        opaque: opaque,
        settings: settings,
      ),
      predicate,
    );
  }

  Future<T?> pushNamedTransition<T>({
    required String routeName,
    required PageTransitionType type,
    Object? arguments,
    Duration duration = const Duration(milliseconds: 200),
    Curve curve = Curves.linear,
    bool fullscreenDialog = false,
    bool opaque = false,
  }) {
    return Navigator.push<T>(
      this,
      PageTransition(
        settings: RouteSettings(name: routeName, arguments: arguments),
        type: type,
        childBuilder: (context) {
          final route = Navigator.of(context).widget.onGenerateRoute?.call(
                RouteSettings(name: routeName, arguments: arguments),
              ) as PageRoute;
          return route.buildPage(
            context,
            AlwaysStoppedAnimation(1.0),
            AlwaysStoppedAnimation(0.0),
          );
        },
        duration: duration,
        curve: curve,
        fullscreenDialog: fullscreenDialog,
        opaque: opaque,
      ),
    );
  }
}
