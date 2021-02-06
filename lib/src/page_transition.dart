library page_transition;

import 'package:flutter/material.dart';
import 'enum.dart';

/// This package allows you amazing transition for your routes

/// Page transition class extends PageRouteBuilder
class PageTransition<T> extends PageRouteBuilder<T> {
  /// Child for your next page
  final Widget child;

  /// Transition types
  ///  fade,rightToLeft,leftToRight, upToDown,downToUp,scale,rotate,size,rightToLeftWithFade,leftToRightWithFade
  final PageTransitionType type;

  /// Curves for transitions
  final Curve curve;

  /// Aligment for transitions
  final Alignment alignment;

  /// Durationf for your transition default is 300 ms
  final Duration duration;

  /// Context for inheret theme
  final BuildContext ctx;

  /// Optional inheret teheme
  final bool inheritTheme;

  /// Page transition constructor. We can pass the next page as a child,
  PageTransition({
    Key key,
    @required this.child,
    @required this.type,
    this.ctx,
    this.inheritTheme = false,
    this.curve = Curves.linear,
    this.alignment,
    this.duration = const Duration(milliseconds: 300),
    RouteSettings settings,
  })  : assert(inheritTheme ? ctx != null : true,
            "'ctx' cannot be null when 'inheritTheme' is true, set ctx: context"),
        super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return inheritTheme
                ? InheritedTheme.captureAll(
                    ctx,
                    child,
                  )
                : child;
          },
          transitionDuration: duration,
          settings: settings,
          opaque: false,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            switch (type) {
              case PageTransitionType.fade:
                return FadeTransition(opacity: animation, child: child);
                break;

              /// PageTransitionType.rightToLeft which is the give us right to left transition
              case PageTransitionType.rightToLeft:
                return SlideTransition(
                  transformHitTests: false,
                  position: new Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: curve,
                    ),
                  ),
                  child: new SlideTransition(
                    position: new Tween<Offset>(
                      begin: Offset.zero,
                      end: const Offset(-1.0, 0.0),
                    ).animate(
                      CurvedAnimation(
                        parent: secondaryAnimation,
                        curve: curve,
                      ),
                    ),
                    child: child,
                  ),
                );
                break;

              /// PageTransitionType.leftToRight which is the give us left to right transition

              case PageTransitionType.leftToRight:
                return SlideTransition(
                  transformHitTests: false,
                  position: Tween<Offset>(
                    begin: const Offset(-1.0, 0.0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: curve,
                    ),
                  ),
                  child: new SlideTransition(
                    position: new Tween<Offset>(
                      begin: Offset.zero,
                      end: const Offset(1.0, 0.0),
                    ).animate(
                      CurvedAnimation(
                        parent: secondaryAnimation,
                        curve: curve,
                      ),
                    ),
                    child: child,
                  ),
                );
                break;

              /// PageTransitionType.upToDown which is the give us up to down transition

              case PageTransitionType.topToBottom:
                return SlideTransition(
                  transformHitTests: false,
                  position: Tween<Offset>(
                    begin: const Offset(0.0, -1.0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: curve,
                    ),
                  ),
                  child: new SlideTransition(
                    position: new Tween<Offset>(
                      begin: Offset.zero,
                      end: const Offset(0.0, 1.0),
                    ).animate(
                      CurvedAnimation(
                        parent: secondaryAnimation,
                        curve: curve,
                      ),
                    ),
                    child: child,
                  ),
                );
                break;

              /// PageTransitionType.downToUp which is the give us down to up transition

              case PageTransitionType.bottomToTop:
                return SlideTransition(
                  transformHitTests: false,
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 1.0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: curve,
                    ),
                  ),
                  child: new SlideTransition(
                    position: new Tween<Offset>(
                      begin: Offset.zero,
                      end: const Offset(0.0, -1.0),
                    ).animate(
                      CurvedAnimation(
                        parent: secondaryAnimation,
                        curve: curve,
                      ),
                    ),
                    child: child,
                  ),
                );
                break;

              /// PageTransitionType.scale which is the scale functionality for transition you can also use curve for this transition

              case PageTransitionType.scale:
                return ScaleTransition(
                  alignment: alignment,
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
                break;

              /// PageTransitionType.rotate which is the rotate functionality for transition you can also use alignment for this transition

              case PageTransitionType.rotate:
                return new RotationTransition(
                  alignment: alignment,
                  turns: animation,
                  child: new ScaleTransition(
                    alignment: alignment,
                    scale: animation,
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  ),
                );
                break;

              /// PageTransitionType.size which is the rotate functionality for transition you can also use curve for this transition

              case PageTransitionType.size:
                return Align(
                  alignment: alignment,
                  child: SizeTransition(
                    sizeFactor: CurvedAnimation(
                      parent: animation,
                      curve: curve,
                    ),
                    child: child,
                  ),
                );
                break;

              /// PageTransitionType.rightToLeftWithFade which is the fade functionality from right o left

              case PageTransitionType.rightToLeftWithFade:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset.zero,
                        end: const Offset(-1.0, 0.0),
                      ).animate(
                        CurvedAnimation(
                          parent: secondaryAnimation,
                          curve: curve,
                        ),
                      ),
                      child: child,
                    ),
                  ),
                );
                break;

              /// PageTransitionType.leftToRightWithFade which is the fade functionality from left o right with curve

              case PageTransitionType.leftToRightWithFade:
                return SlideTransition(
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
                        begin: Offset.zero,
                        end: const Offset(1.0, 0.0),
                      ).animate(
                        CurvedAnimation(
                          parent: secondaryAnimation,
                          curve: curve,
                        ),
                      ),
                      child: child,
                    ),
                  ),
                );
                break;

              /// FadeTransitions which is the fade transition

              default:
                return FadeTransition(opacity: animation, child: child);
            }
          },
        );
}
