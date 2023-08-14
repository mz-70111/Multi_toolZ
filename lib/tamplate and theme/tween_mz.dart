import 'package:flutter/material.dart';

class TweenMz {
  static opacitiy(
      {begin = 0.0, end = 1.0, durationinmilliseconds = 100, child}) {
    return TweenAnimationBuilder<double>(
        tween: Tween(begin: begin, end: end),
        duration: Duration(milliseconds: durationinmilliseconds),
        builder: (_, end0, child0) {
          return Opacity(
            opacity: end0,
            child: child,
          );
        });
  }
}
