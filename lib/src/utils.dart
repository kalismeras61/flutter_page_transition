import 'package:flutter/material.dart';

// ignore: public_member_api_docs
class Transitions {
  static slideTransition(animation, child) => SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
}
