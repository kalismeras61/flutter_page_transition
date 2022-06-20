// ignore: public_member_api_docs
import 'package:flutter/material.dart';

import '../page_transition.dart';

// ignore: public_member_api_docs
class IosPageTransition<T> extends PageRoute<T> {
  // ignore: public_member_api_docs
  final PageTransitionsBuilder matchingBuilder =
      const CupertinoPageTransitionsBuilder(); // Default iOS/macOS (to get the swipe right to go back gesture)
  // final PageTransitionsBuilder matchingBuilder = const FadeUpwardsPageTransitionsBuilder(); // Default Android/Linux/Windows
  /// Child for your next page
  final Widget child;

  /// Child for your next page
  final Widget? childCurrent;

  /// Transition types
  ///  fade,rightToLeft,leftToRight, upToDown,downToUp,scale,rotate,size,rightToLeftWithFade,leftToRightWithFade
  final PageTransitionType type;

  /// Curves for transitions
  final Curve curve;

  /// Alignment for transitions
  final Alignment? alignment;

  /// Duration for your transition default is 300 ms
  final Duration? duration;

  /// Context for inherit theme
  final BuildContext? ctx;

  /// Optional inherit theme
  final bool inheritTheme;

  /// Optional fullscreen dialog mode
  final bool fullscreenDialog;

  // ignore: public_member_api_docs
  IosPageTransition({
    required this.child,
    required this.type,
    RouteSettings? settings,
    this.inheritTheme = false,
    this.curve = Curves.linear,
    this.childCurrent,
    this.ctx,
    this.alignment,
    this.duration,
    this.reverseTransitionDuration = const Duration(milliseconds: 300),
    this.fullscreenDialog = false,
  }) : super(
          settings: settings,
          fullscreenDialog: fullscreenDialog,
        );

  @override
  Color? get barrierColor => Colors.transparent;

  @override
  final Duration reverseTransitionDuration;

  @override
  String? get barrierLabel => null;
  @override
  bool get barrierDismissible => false;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return inheritTheme
        ? InheritedTheme.captureAll(
            ctx!,
            child,
          )
        : child;
  }

  @override
  bool get maintainState => true;

  @override
  bool get opaque => true;

  @override
  Duration get transitionDuration => duration ?? Duration(milliseconds: 300);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    var chilData;
    switch (type) {
      case PageTransitionType.fade:
        chilData = FadeTransition(opacity: animation, child: child);
        // ignore: dead_code
        break;

      /// PageTransitionType.rightToLeft which is the give us right to left transition
      case PageTransitionType.rightToLeft:
        chilData = SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
        // ignore: dead_code
        break;

      /// PageTransitionType.leftToRight which is the give us left to right transition
      case PageTransitionType.leftToRight:
        chilData = SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
        // ignore: dead_code
        break;

      /// PageTransitionType.topToBottom which is the give us up to down transition
      case PageTransitionType.topToBottom:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
        // ignore: dead_code
        break;

      /// PageTransitionType.downToUp which is the give us down to up transition
      case PageTransitionType.bottomToTop:
        chilData = SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
        // ignore: dead_code
        break;

      /// PageTransitionType.scale which is the scale functionality for transition you can also use curve for this transition

      case PageTransitionType.scale:
        assert(alignment != null, """
                When using type "scale" you need argument: 'alignment'
                """);
        chilData = ScaleTransition(
          alignment: alignment!,
          scale: CurvedAnimation(
            parent: animation,
            curve: Interval(
              0.00,
              0.50,
              curve: curve,
            ),
          ),
          child: child,
        );
        // ignore: dead_code
        break;

      /// PageTransitionType.rotate which is the rotate functionality for transition you can also use alignment for this transition

      case PageTransitionType.rotate:
        chilData = new RotationTransition(
          alignment: alignment!,
          turns: animation,
          child: ScaleTransition(
            alignment: alignment!,
            scale: animation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          ),
        );
        // ignore: dead_code
        break;

      /// PageTransitionType.size which is the rotate functionality for transition you can also use curve for this transition

      case PageTransitionType.size:
        chilData = Align(
          alignment: alignment!,
          child: SizeTransition(
            sizeFactor: CurvedAnimation(
              parent: animation,
              curve: curve,
            ),
            child: child,
          ),
        );
        // ignore: dead_code
        break;

      /// PageTransitionType.rightToLeftWithFade which is the fade functionality from right o left

      case PageTransitionType.rightToLeftWithFade:
        chilData = SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          ),
        );
        // ignore: dead_code
        break;

      /// PageTransitionType.leftToRightWithFade which is the fade functionality from left o right with curve

      case PageTransitionType.leftToRightWithFade:
        chilData = SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1.0, 0.0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: curve,
            ),
          ),
          child: FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          ),
        );
        // ignore: dead_code
        break;

      case PageTransitionType.rightToLeftJoined:
        assert(childCurrent != null, """
                When using type "rightToLeftJoined" you need argument: 'childCurrent'

                example:
                  child: MyPage(),
                  childCurrent: this

                """);
        chilData = Stack(
          children: <Widget>[
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.0),
                end: const Offset(-1.0, 0.0),
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: curve,
                ),
              ),
              child: childCurrent,
            ),
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: curve,
                ),
              ),
              child: child,
            )
          ],
        );
        // ignore: dead_code
        break;

      case PageTransitionType.leftToRightJoined:
        assert(childCurrent != null, """
                When using type "leftToRightJoined" you need argument: 'childCurrent'
                example:
                  child: MyPage(),
                  childCurrent: this

                """);
        chilData = Stack(
          children: <Widget>[
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1.0, 0.0),
                end: const Offset(0.0, 0.0),
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: curve,
                ),
              ),
              child: child,
            ),
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.0),
                end: const Offset(1.0, 0.0),
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: curve,
                ),
              ),
              child: childCurrent,
            )
          ],
        );
        // ignore: dead_code
        break;

      case PageTransitionType.rightToLeftPop:
        assert(childCurrent != null, """
                When using type "rightToLeftPop" you need argument: 'childCurrent'

                example:
                  child: MyPage(),
                  childCurrent: this

                """);
        chilData = Stack(
          children: <Widget>[
            child,
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.0),
                end: const Offset(-1.0, 0.0),
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: curve,
                ),
              ),
              child: childCurrent,
            ),
          ],
        );
        // ignore: dead_code
        break;

      case PageTransitionType.leftToRightPop:
        assert(childCurrent != null, """
                When using type "leftToRightPop" you need argument: 'childCurrent'
                example:
                  child: MyPage(),
                  childCurrent: this

                """);
        chilData = Stack(
          children: <Widget>[
            child,
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.0),
                end: const Offset(1.0, 0.0),
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: curve,
                ),
              ),
              child: childCurrent,
            )
          ],
        );
        // ignore: dead_code
        break;

      /// FadeTransitions which is the fade transition

      default:
        chilData = FadeTransition(opacity: animation, child: child);
    }
    return matchingBuilder.buildTransitions(
        this, context, animation, secondaryAnimation, chilData);
  }
}
