import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_tools_mz/controllers/main_controller.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/tween_mz.dart';
import 'package:flutter/foundation.dart' as platformweb;

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static int waittime = 0;
  static Color waitcolor = Colors.greenAccent;
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
                ? Image.network("assets/images/takamollogo.png")
                : Image.asset("images/takamollogo.png")),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          GetBuilder<MainController>(
              init: mainController,
              builder: (_) => SizedBox(
                  width: 100,
                  child: LinearProgressIndicator(
                    color: waitcolor,
                    backgroundColor: Colors.black,
                    minHeight: 10,
                  )))
        ])
      ])),
      const Divider(),
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "by:",
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
          TweenMz.opacitiy(
              durationinmilliseconds: 1000,
              child: Text(
                "معاذ الحوراني",
                style: Theme.of(context).textTheme.labelSmall,
              )),
        ],
      )
    ]));
  }
}
