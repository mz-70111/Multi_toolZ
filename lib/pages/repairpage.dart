import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_tools_mz/controllers/db_controller.dart';
import 'package:multi_tools_mz/controllers/main_controller.dart';
import 'package:multi_tools_mz/pages/login.dart';
import 'package:multi_tools_mz/pages/splash_screen.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/database.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/info_basic.dart';

class RepairPage extends StatelessWidget {
  const RepairPage({super.key});

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find();
    DBController dbController = Get.find();
    return GetBuilder<DBController>(
      init: dbController,
      builder: (_) => Scaffold(
          body: FutureBuilder(
              future: Future.delayed(const Duration(seconds: 2), () async {
                DB.allofficeinfotable =
                    await DBController().getallofficeinfotable();
                DB.allusersinfotable =
                    await DBController().getallusersinfotable();
                return DB.versioninfotable =
                    await DBController().getversioninfo();
              }),
              builder: (_, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  mainController.waitcountdown();
                  return const SplashScreen();
                } else if (!snap.hasData) {
                  SplashScreen.waittime = 1;
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("لا يمكن الوصول للمخدم"),
                        IconButton(
                            onPressed: () {
                              dbController.update();
                            },
                            icon: const Icon(Icons.refresh)),
                      ],
                    ),
                  );
                } else {
                  SplashScreen.waittime = 1;
                  if (DB.versioninfotable[0]['version'][0]['version'] ==
                      InfoBasic.version) {
                    return const LogIn();
                  } else {
                    return Center(
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 300,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('''يوجد تحديث جديد للتطبيق'''),
                                InkWell(
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.android,
                                        size: 35,
                                      ),
                                      Text("Android"),
                                    ],
                                  ),
                                  onTap: () async {
                                    await mainController.urllaunch(
                                        url:
                                            '${DB.versioninfotable[0]['version'][0]['android']}');
                                  },
                                ),
                                InkWell(
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.window,
                                          size: 35,
                                        ),
                                        Text('Windows'),
                                      ],
                                    ),
                                    onTap: () async {
                                      await mainController.urllaunch(
                                          url:
                                              '${DB.versioninfotable[0]['version'][0]['windows']}');
                                    }),
                                InkWell(
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.web,
                                          size: 35,
                                        ),
                                        Text('Web'),
                                      ],
                                    ),
                                    onTap: () async {
                                      await mainController.urllaunch(
                                          url:
                                              '${DB.versioninfotable[0]['version'][0]['web']}');
                                    }),
                                Visibility(
                                    visible: DB.versioninfotable[0]['version']
                                                [0]['skip'] ==
                                            '1'
                                        ? true
                                        : false,
                                    child: Card(
                                      child: TextButton(
                                          onPressed: () {
                                            Get.offNamed('/login');
                                          },
                                          child: const Text("تخطي")),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                }
              })),
    );
  }
}
/*
            for web platform
    1. step- go to flutter\bin\cache and remove a file named: flutter_tools.stamp.
    2. step- go to flutter\packages\flutter_tools\lib\src\web and open the file chrome.dart.
    3. step- find '--disable-extensions' remove and add 4.step.
    4. step- add '--disable-web-security'
            */
