library page_transition;

import 'package:flutter/material.dart';

class PageTransition<T> extends PageRouteBuilder<T> {
  final Widget child;
  final String type;
  final Curve curve ;

  PageTransition({Key key, @required this.child, @required this.type, this.curve = Curves.linear})
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }, transitionsBuilder: (BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    switch (type) {
      case 'fade':
        return FadeTransition(opacity: animation, child: child);
        break;
      case 'rightToLeft':
        return SlideTransition(
          transformHitTests: true,
          position: new Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: new SlideTransition(
            position: new Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(1.0, 0.0),
            ).animate(secondaryAnimation),
            child: child,
          ),
        );
        break;
      case 'leftToRight':
        return SlideTransition(
          transformHitTests: true,
          position: Tween<Offset>(
            begin: const Offset(-1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: new SlideTransition(

            position: new Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(-1.0, 0.0),
            ).animate(secondaryAnimation),
            child: child,
          ),
        );
        break;
      case 'scale':
        return ScaleTransition(
          scale: new Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Interval(
                0.00,
                0.50,
                curve: curve,
              ),
            ),
          ),
          child: ScaleTransition(
            scale: Tween<double>(
              begin: 1.5,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Interval(
                  0.50,
                  1.00,
                  curve:  curve,
                ),
              ),
            ),
            child: child,
          ),
        );
        break;
      case 'transform':
        return new RotationTransition(
          turns: animation,
          child: new ScaleTransition(
            scale: animation,
            child: new FadeTransition(
              opacity: animation,
              child: child,
            ),
          ),
        );
        break;
      case 'size' :
        return Align(
          child: SizeTransition(
            sizeFactor:
            CurvedAnimation(
              parent: animation,
              curve: curve,
            ),
            child: child,),
        );
        break;
      default:
        return FadeTransition(opacity: animation, child: child);
    }
  });
}