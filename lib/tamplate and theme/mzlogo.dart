import 'dart:math';

import 'package:flutter/material.dart';

class MZLogo extends StatelessWidget {
  const MZLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            height: 50,
            width: 70,
            color: Colors.transparent,
          ),
          Positioned(
              left: 5,
              top: 8,
              child: Container(
                width: 8,
                height: 35,
                color: Colors.redAccent,
              )),
          Positioned(
              left: 8,
              top: 5,
              child: Transform.rotate(
                angle: pi * 90 / 180,
                child: Container(
                  width: 10,
                  height: 20,
                  color: Colors.black,
                ),
              )),
          Positioned(
              left: 27,
              top: 5,
              child: Transform.rotate(
                angle: pi * 50 / 180,
                child: Container(
                  width: 7,
                  height: 35,
                  color: Colors.redAccent,
                ),
              )),
          Positioned(
              left: 35,
              top: 8,
              child: Container(
                width: 8,
                height: 35,
                color: Colors.black,
              )),
          Positioned(
              left: 45,
              top: 10,
              child: Transform.rotate(
                angle: pi * 50 / 180,
                child: Container(
                  width: 7,
                  height: 35,
                  color: Colors.redAccent,
                ),
              )),
        ],
      ),
    );
  }
}
