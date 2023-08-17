import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_tools_mz/controllers/main_controller.dart';
import 'package:multi_tools_mz/controllers/theme_controller.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/theme_Mz.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/tween_mz.dart';

MainController mainController = Get.find();
ThemeController themeController = Get.find();

class BottomNavBarMz extends StatelessWidget {
  const BottomNavBarMz({super.key});
  static int selecteditem = 0;
  static List bottomnavitem = [
    {
      'visible': true,
      'angle': 45.0,
      'y': -AppBar().preferredSize.height / 3,
      'icon': Icons.home,
      'backcolor': ThemeMz.mode == 'light' ? Colors.white54 : Colors.black45,
      'action': () => mainController.navbaraction(x: 0),
      'x': 0
    },
    {
      'visible': true,
      'angle': 0.0,
      'y': 0.0,
      'icon': Icons.chat,
      'backcolor': ThemeMz.mode == 'light'
          ? Colors.deepPurpleAccent.withOpacity(0.6)
          : Colors.amberAccent.withOpacity(0.6),
      'action': () => mainController.navbaraction(x: 1),
      'x': 1
    },
    {
      'visible': false,
      'angle': 0.0,
      'y': 0.0,
      'icon': Icons.report,
      'backcolor': ThemeMz.mode == 'light'
          ? Colors.deepPurpleAccent.withOpacity(0.6)
          : Colors.amberAccent.withOpacity(0.6),
      'action': () => mainController.navbaraction(x: 2),
      'x': 2
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 20,
        child: Container(
            color: ThemeMz.mode == 'light'
                ? Colors.deepPurpleAccent.withOpacity(0.6)
                : Colors.amberAccent.withOpacity(0.6),
            height: AppBar().preferredSize.height,
            child: GetBuilder<MainController>(
                init: mainController,
                builder: (_) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ...bottomnavitem
                              .where((e) => e['visible'] == true)
                              .map((e) => TweenMz.rotate(
                                  durationinmilliseconds: 300,
                                  end: e['angle'],
                                  child: TweenMz.translatey(
                                      end: e['y'],
                                      child: Card(
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: e['backcolor'],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.elliptical(
                                                              15, 5))),
                                              height: 50,
                                              width: 50,
                                              child: TweenMz.rotate(
                                                  durationinmilliseconds: 300,
                                                  end: -e['angle'],
                                                  child: IconButton(
                                                    icon: Icon(e['icon']),
                                                    onPressed: e['action'],
                                                  )))))))
                        ]))));
  }
}
