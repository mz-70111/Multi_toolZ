import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_tools_mz/controllers/db_controller.dart';
import 'package:multi_tools_mz/controllers/theme_controller.dart';
import 'package:multi_tools_mz/pages/homepage.dart';
import 'package:multi_tools_mz/pages/splash_screen.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/theme_Mz.dart';

main() => runApp(const MultiToolz());

class MultiToolz extends StatelessWidget {
  const MultiToolz({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.put(ThemeController());
    DBController dbController = Get.put(DBController());
    return GetBuilder<ThemeController>(
      init: themeController,
      builder: (_) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeMz.theme(),
        home: const SplashScreen(),
        getPages: [
          GetPage(name: '/', page: (() => const SplashScreen())),
          GetPage(name: '/homepage', page: (() => const HomePage())),
          GetPage(name: '/splash', page: (() => const HomePage()))
        ],
      ),
    );
  }
}
