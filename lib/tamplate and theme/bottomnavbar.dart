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
      'backcolor': ThemeMz.mode == 'light' ? Colors.white : Colors.black,
      'bordercolor':
          ThemeMz.mode == 'light' ? Colors.deepPurple : Colors.amberAccent,
      'action': () => mainController.navbaraction(x: 0),
      'x': 0,
      'size': 1,
    },
    {
      'visible': true,
      'angle': 0.0,
      'y': 0.0,
      'icon': Icons.chat,
      'backcolor': ThemeMz.mode == 'light' ? Colors.white54 : Colors.black54,
      'bordercolor': Colors.transparent,
      'action': () async => await mainController.navbaraction(x: 1),
      'x': 1,
      'size': 1,
    },
    {
      'visible': false,
      'angle': 0.0,
      'y': 0.0,
      'icon': Icons.report,
      'backcolor': ThemeMz.mode == 'light' ? Colors.white54 : Colors.black54,
      'bordercolor': Colors.transparent,
      'action': () => mainController.navbaraction(x: 2),
      'x': 2,
      'size': 1,
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: ThemeMz.mode == 'light' ? Colors.white54 : Colors.black54,
          border: Border.all(
              color: ThemeMz.mode == 'light'
                  ? Colors.deepPurple
                  : Colors.amberAccent),
        ),
        height: AppBar().preferredSize.height,
        child: GetBuilder<MainController>(
            init: mainController,
            builder: (_) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ...bottomnavitem.where((e) => e['visible'] == true).map(
                          (e) => TweenMz.rotate(
                              durationinmilliseconds: 300,
                              end: e['angle'],
                              child: TweenMz.translatey(
                                  end: e['y'],
                                  child: Container(
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: e['bordercolor'],
                                                offset: Offset(2, 2))
                                          ],
                                          color: e['backcolor'],
                                          border: Border.all(
                                              width: 2,
                                              color: e['bordercolor']),
                                          borderRadius: const BorderRadius.all(
                                              Radius.elliptical(10, 5))),
                                      height: 50,
                                      width: 50,
                                      child: TweenMz.rotate(
                                          durationinmilliseconds: 300,
                                          end: -e['angle'],
                                          child: IconButton(
                                            icon: Icon(
                                              e['icon'],
                                              color: ThemeMz.mode == 'light'
                                                  ? Colors.deepPurple
                                                  : Colors.yellowAccent,
                                            ),
                                            onPressed: e['action'],
                                          ))))))
                    ])));
  }
}
