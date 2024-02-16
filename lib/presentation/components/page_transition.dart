import 'package:flutter/material.dart';

class CustomPageTransition extends PageRouteBuilder {
  final Widget widget;
  final Alignment alignment;

  CustomPageTransition({required this.widget, required this.alignment})
      : super(
          opaque: false,
          pageBuilder: (context, animation, secondaryAnimation) => widget,
          transitionDuration: const Duration(milliseconds: 1500),
          reverseTransitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            animation = CurvedAnimation(
              parent: animation,
              curve: Curves.linearToEaseOut,
              // curve: Curves.decelerate,
              // curve: Curves.bounceOut,
              // curve: Curves.elasticIn,
              // curve: Curves.elasticInOut,
              reverseCurve: Curves.fastOutSlowIn,
            );
            return ScaleTransition(
              scale: animation,
              alignment: alignment,
              child: child,
            );
          },
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.5),
        );
}
