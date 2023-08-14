import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_tools_mz/controllers/db_controller.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/theme_mz.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/tween_mz.dart';
import 'package:flutter/foundation.dart' as platformweb;

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    DBController dbController = Get.find();

    Future.delayed(const Duration(seconds: 2), () async {
      return await Get.toNamed('/homepage');
    });
    return Scaffold(
        body: Column(children: [
      Expanded(
        child: TweenMz.opacitiy(
            durationinmilliseconds: 2000,
            child: platformweb.kIsWeb
                ? Image.network("assets\\images\\takamollogo.png")
                : Image.asset("assets\\images\\takamollogo.png")),
      ),
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
