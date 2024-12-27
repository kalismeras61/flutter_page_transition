library page_transition;

import 'package:flutter/material.dart';

import 'enum.dart';

/// This package allows you amazing transition for your routes

/// Page transition class extends PageRouteBuilder
class PageTransition<T> extends PageRouteBuilder<T> {
  /// Child for your next page
  final Widget child;

  // ignore: public_member_api_docs
  final PageTransitionsBuilder matchingBuilder;

  /// Child for your next page
  final Widget? childCurrent;

  /// Transition types
  ///  fade,rightToLeft,leftToRight, upToDown,downToUp,scale,rotate,size,rightToLeftWithFade,leftToRightWithFade
  final PageTransitionType type;

  /// Transition types
  final PageTransitionType? reverseType;

  /// Curves for transitions
  final Curve curve;

  /// Alignment for transitions
  final Alignment? alignment;

  /// Duration for your transition default is 300 ms
  final Duration duration;

  /// Duration for your pop transition default is 300 ms
  final Duration? reverseDuration;

  /// Context for inherit theme
  final BuildContext? ctx;

  /// Optional inherit theme
  final bool inheritTheme;

  /// Optional fullscreen dialog mode
  final bool fullscreenDialog;

  final bool opaque;

  // ignore: public_member_api_docs
  final bool isIos;

  // ignore: public_member_api_docs
  final bool? maintainStateData;

  /// Page transition constructor. We can pass the next page as a child,
  PageTransition({
    Key? key,
    required this.child,
    required this.type,
    this.childCurrent = null,
    this.ctx,
    this.inheritTheme = false,
    this.curve = Curves.linear,
    this.alignment,
    this.duration = const Duration(milliseconds: 200),
    this.reverseDuration = const Duration(milliseconds: 200),
    this.fullscreenDialog = false,
    this.opaque = false,
    this.isIos = false,
    this.matchingBuilder = const CupertinoPageTransitionsBuilder(),
    this.maintainStateData,
    this.reverseType,
    RouteSettings? settings,
  })  : assert(inheritTheme ? ctx != null : true,
            "'ctx' cannot be null when 'inheritTheme' is true, set ctx: context"),
        super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return inheritTheme
                ? InheritedTheme.captureAll(ctx!, child)
                : child;
          },
          settings: settings,
          maintainState: maintainStateData ?? true,
          opaque: opaque,
          fullscreenDialog: fullscreenDialog,
        );

  @override
  Duration get transitionDuration => duration;

  @override
  // ignore: public_member_api_docs
  Duration get reverseTransitionDuration => reverseDuration ?? duration;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    final curvedAnimation = CurvedAnimation(parent: animation, curve: curve);
    final curvedSecondaryAnimation =
        CurvedAnimation(parent: secondaryAnimation, curve: curve);
    switch (type) {
      case PageTransitionType.theme:
        return Theme.of(context).pageTransitionsTheme.buildTransitions(
              this,
              context,
              curvedAnimation,
              curvedSecondaryAnimation,
              child,
            );

      case PageTransitionType.fade:
        final fadeTransition = FadeTransition(
          opacity: curvedAnimation,
          child: child,
        );
        if (isIos) {
          return matchingBuilder.buildTransitions(
            this,
            context,
            curvedAnimation,
            curvedSecondaryAnimation,
            fadeTransition,
          );
        }
        return fadeTransition;

      /// PageTransitionType.rightToLeft which is the give us right to left transition
      case PageTransitionType.rightToLeft:
        var slideTransition = SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: child,
        );
        if (isIos) {
          return matchingBuilder.buildTransitions(
            this,
            context,
            curvedAnimation,
            curvedSecondaryAnimation,
            child,
          );
        }
        return slideTransition;

      /// PageTransitionType.leftToRight which is the give us left to right transition
      case PageTransitionType.leftToRight:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: child,
        );

      /// PageTransitionType.topToBottom which is the give us up to down transition
      case PageTransitionType.topToBottom:
        var slideTransition = SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: child,
        );
        if (isIos) {
          return matchingBuilder.buildTransitions(
            this,
            context,
            curvedAnimation,
            curvedSecondaryAnimation,
            slideTransition,
          );
        }
        return slideTransition;

      /// PageTransitionType.downToUp which is the give us down to up transition
      case PageTransitionType.bottomToTop:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: child,
        );

      /// PageTransitionType.scale which is the scale functionality for transition you can also use curve for this transition

      case PageTransitionType.scale:
        assert(alignment != null, """
                When using type "scale" you need argument: 'alignment'
                """);
        var scaleTransition = ScaleTransition(
          alignment: alignment!,
          scale: curvedAnimation,
          child: child,
        );
        if (isIos) {
          return matchingBuilder.buildTransitions(
            this,
            context,
            curvedAnimation,
            curvedSecondaryAnimation,
            scaleTransition,
          );
        }
        return scaleTransition;

      /// PageTransitionType.rotate which is the rotate functionality for transition you can also use alignment for this transition

      case PageTransitionType.rotate:
        assert(alignment != null, """
                When using type "RotationTransition" you need argument: 'alignment'
                """);
        return new RotationTransition(
          alignment: alignment!,
          turns: curvedAnimation,
          child: ScaleTransition(
            alignment: alignment!,
            scale: curvedAnimation,
            child: FadeTransition(
              opacity: curvedAnimation,
              child: child,
            ),
          ),
        );

      /// PageTransitionType.size which is the rotate functionality for transition you can also use curve for this transition

      case PageTransitionType.size:
        assert(alignment != null, """
                When using type "size" you need argument: 'alignment'
                """);
        return Align(
          alignment: alignment!,
          child: SizeTransition(
            sizeFactor: CurvedAnimation(
              parent: curvedAnimation,
              curve: curve,
            ),
            child: child,
          ),
        );

      /// PageTransitionType.rightToLeftWithFade which is the fade functionality from right o left

      case PageTransitionType.rightToLeftWithFade:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: FadeTransition(
            opacity: curvedAnimation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            ),
          ),
        );

      /// PageTransitionType.leftToRightWithFade which is the fade functionality from left o right with curve

      case PageTransitionType.leftToRightWithFade:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1.0, 0.0),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: FadeTransition(
            opacity: curvedAnimation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1, 0),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            ),
          ),
        );

      case PageTransitionType.rightToLeftJoined:
        assert(childCurrent != null, """
                When using type "rightToLeftJoined" you need argument: 'childCurrent'

                example:
                  child: MyPage(),
                  childCurrent: this

                """);

        return Stack(
          children: <Widget>[
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.0),
                end: const Offset(-1.0, 0.0),
              ).animate(curvedAnimation),
              child: childCurrent,
            ),
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            )
          ],
        );

      case PageTransitionType.leftToRightJoined:
        assert(childCurrent != null, """
                When using type "leftToRightJoined" you need argument: 'childCurrent'
                example:
                  child: MyPage(),
                  childCurrent: this

                """);
        return Stack(
          children: <Widget>[
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1.0, 0.0),
                end: const Offset(0.0, 0.0),
              ).animate(curvedAnimation),
              child: child,
            ),
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.0),
                end: const Offset(1.0, 0.0),
              ).animate(curvedAnimation),
              child: childCurrent,
            )
          ],
        );

      case PageTransitionType.topToBottomJoined:
        assert(childCurrent != null, """
                When using type "topToBottomJoined" you need argument: 'childCurrent'
                example:
                  child: MyPage(),
                  childCurrent: this

                """);
        return Stack(
          children: <Widget>[
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, -1.0),
                end: const Offset(0.0, 0.0),
              ).animate(curvedAnimation),
              child: child,
            ),
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.0),
                end: const Offset(0.0, 1.0),
              ).animate(curvedAnimation),
              child: childCurrent,
            )
          ],
        );

      case PageTransitionType.bottomToTopJoined:
        assert(childCurrent != null, """
                When using type "bottomToTopJoined" you need argument: 'childCurrent'
                example:
                  child: MyPage(),
                  childCurrent: this

                """);
        return Stack(
          children: <Widget>[
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: const Offset(0.0, 0.0),
              ).animate(curvedAnimation),
              child: child,
            ),
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.0),
                end: const Offset(0.0, -1.0),
              ).animate(curvedAnimation),
              child: childCurrent,
            )
          ],
        );

      case PageTransitionType.rightToLeftPop:
        assert(childCurrent != null, """
                When using type "rightToLeftPop" you need argument: 'childCurrent'

                example:
                  child: MyPage(),
                  childCurrent: this

                """);
        return Stack(
          children: <Widget>[
            child,
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.0),
                end: const Offset(-1.0, 0.0),
              ).animate(curvedAnimation),
              child: childCurrent,
            ),
          ],
        );

      case PageTransitionType.leftToRightPop:
        assert(childCurrent != null, """
                When using type "leftToRightPop" you need argument: 'childCurrent'
                example:
                  child: MyPage(),
                  childCurrent: this

                """);
        return Stack(
          children: <Widget>[
            child,
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.0),
                end: const Offset(1.0, 0.0),
              ).animate(curvedAnimation),
              child: childCurrent,
            )
          ],
        );

      case PageTransitionType.topToBottomPop:
        assert(childCurrent != null, """
                When using type "topToBottomPop" you need argument: 'childCurrent'
                example:
                  child: MyPage(),
                  childCurrent: this

                """);
        return Stack(
          children: <Widget>[
            child,
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.0),
                end: const Offset(0.0, 1.0),
              ).animate(curvedAnimation),
              child: childCurrent,
            )
          ],
        );

      case PageTransitionType.bottomToTopPop:
        assert(childCurrent != null, """
                When using type "bottomToTopPop" you need argument: 'childCurrent'
                example:
                  child: MyPage(),
                  childCurrent: this

                """);
        return Stack(
          children: <Widget>[
            child,
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.0),
                end: const Offset(0.0, -1.0),
              ).animate(curvedAnimation),
              child: childCurrent,
            )
          ],
        );
    }
  }
}
