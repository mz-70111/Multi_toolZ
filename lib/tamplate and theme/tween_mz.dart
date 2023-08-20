import 'dart:math';

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

  static translatey(
      {begin = 0.0, end = 1.0, durationinmilliseconds = 100, child}) {
    return TweenAnimationBuilder<double>(
        tween: Tween(begin: begin, end: end),
        duration: Duration(milliseconds: durationinmilliseconds),
        builder: (_, end0, child0) {
          return Transform.translate(
            offset: Offset(0.0, end0),
            child: child,
          );
        });
  }

  static translatex(
      {begin = 0.0, end = 1.0, durationinmilliseconds = 100, child}) {
    return TweenAnimationBuilder<double>(
        tween: Tween(begin: begin, end: end),
        duration: Duration(milliseconds: durationinmilliseconds),
        builder: (_, end0, child0) {
          return Transform.translate(
            offset: Offset(end0, 0.0),
            child: child,
          );
        });
  }

  static flip(
      {begin = false, end = true, durationinmilliseconds = 100, child}) {
    return TweenAnimationBuilder<bool>(
        tween: Tween(begin: begin, end: end),
        duration: Duration(milliseconds: durationinmilliseconds),
        builder: (_, end0, child0) {
          return Transform.flip(
            filterQuality: FilterQuality.high,
            flipX: false,
            flipY: end0,
            child: child,
          );
        });
  }

  static rotate({begin = 0.0, end = 0.0, durationinmilliseconds = 100, child}) {
    return TweenAnimationBuilder<double>(
        tween: Tween(begin: begin, end: end),
        duration: Duration(milliseconds: durationinmilliseconds),
        builder: (_, end0, child0) {
          return Transform.rotate(
            angle: end0 * pi / 180,
            child: child,
          );
        });
  }

  static scale({begin = 1, end = 2, durationinmilliseconds = 100, child}) {
    return TweenAnimationBuilder<double>(
        tween: Tween(begin: begin, end: end),
        duration: Duration(milliseconds: durationinmilliseconds),
        builder: (_, end0, child0) {
          return Transform.scale(
            scale: end0,
            child: child,
          );
        });
  }
}
