import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_tools_mz/controllers/main_controller.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/theme_mz.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/tween_mz.dart';
import 'package:flutter/foundation.dart' as platformweb;

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static int waittime = 17;
  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find();
    return Scaffold(
        body: Column(children: [
      Expanded(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TweenMz.opacitiy(
            durationinmilliseconds: 2000,
            child: platformweb.kIsWeb
                ? Image.network("assets\\images\\takamollogo.png")
                : Image.asset("assets\\images\\takamollogo.png")),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          GetBuilder<MainController>(
              init: mainController,
              builder: (_) => SizedBox(
                  width: 100,
                  child: LinearProgressIndicator(
                    color: Colors.yellowAccent,
                    backgroundColor: Colors.black,
                    minHeight: 15,
                    value: 1 - (waittime / 17),
                  )))
        ])
      ])),
      const Divider(),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Developed by: M",
            style: ThemeMz.theme().textTheme.labelMedium,
          ),
          TweenMz.opacitiy(
              durationinmilliseconds: 1000,
              child: Text(
                "معاذ الحوراني",
                style: ThemeMz.theme().textTheme.labelMedium,
              )),
          Text(
            "Z",
            style: ThemeMz.theme().textTheme.labelMedium,
          )
        ],
      )
    ]));
  }
}
