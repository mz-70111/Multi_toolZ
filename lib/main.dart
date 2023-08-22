// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_tools_mz/controllers/chat_controller.dart';
import 'package:multi_tools_mz/controllers/db_controller.dart';
import 'package:multi_tools_mz/controllers/main_controller.dart';
import 'package:multi_tools_mz/controllers/theme_controller.dart';
import 'package:multi_tools_mz/pages/accounts.dart';
import 'package:multi_tools_mz/pages/emails.dart';
import 'package:multi_tools_mz/pages/homepage.dart';
import 'package:multi_tools_mz/pages/logs.dart';
import 'package:multi_tools_mz/pages/office.dart';
import 'package:multi_tools_mz/pages/remind.dart';
import 'package:multi_tools_mz/pages/repairpage.dart';
import 'package:multi_tools_mz/pages/login.dart';
import 'package:multi_tools_mz/pages/splash_screen.dart';
import 'package:multi_tools_mz/pages/tasks.dart';
import 'package:multi_tools_mz/pages/todo.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/theme_Mz.dart';

main() => runApp(const MultiToolz());

class MultiToolz extends StatelessWidget {
  const MultiToolz({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.put(ThemeController());
    MainController mainController = Get.put(MainController());
    DBController dbController = Get.put(DBController());
    ChatController chatController = Get.put(ChatController());
    return GetBuilder<ThemeController>(
      init: themeController,
      builder: (_) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeMz.mode == "light" ? ThemeMz.lighttheme : ThemeMz.darktheme,
        home: const RepairPage(),
        getPages: [
          GetPage(name: '/', page: (() => const SplashScreen())),
          GetPage(name: '/repair', page: (() => const RepairPage())),
          GetPage(name: '/login', page: (() => const LogIn())),
          GetPage(name: '/home', page: (() => const HomePage())),
          GetPage(name: '/logs', page: (() => const Logs())),
          GetPage(name: '/office', page: (() => const Office())),
          GetPage(name: '/accounts', page: (() => const Accounts())),
          GetPage(name: '/tasks', page: (() => const Tasks())),
          GetPage(name: '/todo', page: (() => const Todo())),
          GetPage(name: '/remind', page: (() => const Remind())),
          GetPage(name: '/email', page: (() => const Emails())),
        ],
      ),
    );
  }
}
