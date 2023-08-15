import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_tools_mz/controllers/db_controller.dart';
import 'package:multi_tools_mz/controllers/main_controller.dart';
import 'package:multi_tools_mz/pages/login.dart';
import 'package:multi_tools_mz/pages/splash_screen.dart';
import 'package:multi_tools_mz/php_API/info_basic.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find();
    DBController dbController = Get.find();
    List? version;
    String currentversion = 'v_1.0.1';
    return GetBuilder<DBController>(
      init: dbController,
      builder: (_) => Scaffold(
          body: FutureBuilder(
              future: Future.delayed(
                  const Duration(seconds: 2),
                  () async => version = await dbController.requestpost(
                      url: "${InfoBasic.host}${InfoBasic.customquerypath}",
                      data: {'customquery': 'select * from version;'})),
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
                  if (version![0]['version'] == currentversion) {
                    return const LogIn();
                  } else {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('''يوجد تحديث جديد للتطبيق'''),
                          InkWell(
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Android"),
                                Icon(
                                  Icons.android,
                                  size: 35,
                                ),
                              ],
                            ),
                            onTap: () async {
                              await mainController.urllaunch(
                                  url: '${version![0]['android']}');
                            },
                          ),
                          InkWell(
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Windows'),
                                  Icon(
                                    Icons.window,
                                    size: 35,
                                  ),
                                ],
                              ),
                              onTap: () async {
                                await mainController.urllaunch(
                                    url: '${version![0]['windows']}');
                              }),
                          Visibility(
                              visible: version![0]['skip'] == 1 ? true : false,
                              child: Card(
                                child: TextButton(
                                    onPressed: () {
                                      Get.offNamed('/login');
                                    },
                                    child: const Text("تخطي")),
                              ))
                        ],
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
      
    
    
    