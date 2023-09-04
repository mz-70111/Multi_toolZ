import 'dart:math';

import 'package:flutter/material.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/tween_mz.dart';

class MZLogo extends StatelessWidget {
  const MZLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Stack(
          children: [
            Container(
              height: 50,
              width: 100,
              color: Colors.transparent,
            ),
            Positioned(
              top: 10,
              left: 0,
              child: Container(
                width: 7,
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
            Positioned(
              top: 0,
              left: 10,
              child: TweenMz.rotate(
                end: 90.0,
                durationinmilliseconds: 600,
                child: Container(
                  width: 7,
                  height: 30,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
