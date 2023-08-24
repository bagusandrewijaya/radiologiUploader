import 'dart:ui';

import 'package:flutter/material.dart';

class SimpleFadeWidget extends StatelessWidget {
  final bool reverse;
  final Widget child;
  const SimpleFadeWidget({Key key, @required this.child, @required this.reverse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: reverse ? 1 : 0),
      duration: const Duration(milliseconds: 200),
      child: child,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: lerpDouble(0.7, 1, value),
            child: child,
          ),
        );
      },
    );
  }
}
