import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_tools_mz/controllers/main_controller.dart';
import 'package:multi_tools_mz/controllers/theme_controller.dart';
import 'package:multi_tools_mz/pages/login.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/bottomnavbar.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/info_basic.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/languages.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/shared_pre_mz.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/tween_mz.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static IconData modeicon = Icons.sunny;
  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find();
    ThemeController themeController = Get.find();
    List draweritems() => [
          {
            'title':
                "${Lang.lang['drawerpersonalinfo'][Lang.langlist.indexOf(Lang.selectlanguage)]}",
            'action': () {},
            'icon': Icons.person
          },
          {
            'title':
                "${Lang.lang['drawerpesonalchgpass'][Lang.langlist.indexOf(Lang.selectlanguage)]}",
            'action': () {},
            'icon': Icons.password
          },
          {
            'title':
                "${Lang.lang['logout'][Lang.langlist.indexOf(Lang.selectlanguage)]}",
            'icon': Lang.selectlanguage == 'Ar' ? Icons.logout : Icons.logout,
            'action': () async => await mainController.logout()
          },
        ];
    List appbaritems() => [
          {'icon': Icons.notifications, 'action': () {}},
          {
            'icon': modeicon,
            'action': () async => await themeController.changetheme()
          },
        ];

    return FutureBuilder(
        future:
            Future(() => LogIn.userinfo = SharedPreMz.sharedPreMzGetLogin()),
        builder: (_, snap) {
          if (LogIn.userinfo != null) {
            return SafeArea(
                child: GetBuilder<ThemeController>(
              init: themeController,
              builder: (_) => Directionality(
                textDirection: InfoBasic.textDirection(),
                child: Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text(
                      "${Lang.lang['homepageapptitle'][Lang.langlist.indexOf(Lang.selectlanguage)]}",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    actions: [
                      ...appbaritems().map((e) => IconButton(
                          onPressed: e['action'], icon: Icon(e['icon'])))
                    ],
                  ),
                  drawer: Drawer(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...draweritems().map((e) => TweenMz.translatex(
                            durationinmilliseconds: 300,
                            begin: -200.0,
                            end: 0.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton.icon(
                                      onPressed: e['action'],
                                      icon: Icon(e['icon']),
                                      label: Text(e['title'])),
                                ),
                                Divider()
                              ],
                            ),
                          )),
                      Expanded(child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [
                          Text(
                              "${Lang.lang['choselang'][Lang.langlist.indexOf(Lang.selectlanguage)]}"),
                          Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: themeController.chooselang())
                        ]),
                      ),
                    ],
                  )),
                  body: Column(
                    children: [Text("HomePage")],
                  ),
                  bottomNavigationBar: BottomNavBarMz(),
                ),
              ),
            ));
          } else {
            Future(() => Get.offAllNamed('/login'));
            return SizedBox();
          }
        });
  }
}
