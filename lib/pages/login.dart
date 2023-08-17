// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_tools_mz/controllers/main_controller.dart';
import 'package:multi_tools_mz/controllers/theme_controller.dart';
import 'package:multi_tools_mz/pages/splash_screen.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/info_basic.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/languages.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/textfield_mz.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/tween_mz.dart';
import 'package:flutter/foundation.dart' as platformweb;

class LogIn extends StatelessWidget {
  const LogIn({super.key});
  static TextEditingController usernamecontroller = TextEditingController();
  static TextEditingController passwordcontroller = TextEditingController();
  static TextEditingController newpasswordcontroller = TextEditingController();
  static TextEditingController newpasswordconfirmcontroller =
      TextEditingController();
  static bool passwordvisible = true, loginwait = false, chgpassvis = false;
  static IconData iconvisible = Icons.visibility_off;
  static String? loginerrormsg, mainloginerrormsg;
  static List<String>? userinfo;
  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.find();
    MainController mainController = Get.find();
    List loginelements() => [
          {
            'visible': true,
            'label': Lang.lang['logineusernamelabel']
                [Lang.langlist.indexOf(Lang.selectlanguage)],
            'controller': usernamecontroller,
            'icon': Icons.person,
            'action': () => null,
            'readonly': chgpassvis
          },
          {
            'visible': !chgpassvis,
            'label': Lang.lang['loginepasswordlabel']
                [Lang.langlist.indexOf(Lang.selectlanguage)],
            'controller': passwordcontroller,
            'icon': iconvisible,
            'action': () => mainController.hideshowpasswordLogin(),
            'obscuretext': passwordvisible,
            'error': loginerrormsg
          },
          {
            'visible': chgpassvis,
            'label': Lang.lang['loginenewpasswordlabel']
                [Lang.langlist.indexOf(Lang.selectlanguage)],
            'controller': newpasswordcontroller,
            'icon': iconvisible,
            'action': () => mainController.hideshowpasswordLogin(),
            'obscuretext': passwordvisible,
            'error': loginerrormsg
          },
          {
            'visible': chgpassvis,
            'label': Lang.lang['loginenewpasswordconfirmlabel']
                [Lang.langlist.indexOf(Lang.selectlanguage)],
            'controller': newpasswordconfirmcontroller,
            'icon': iconvisible,
            'action': () => mainController.hideshowpasswordLogin(),
            'obscuretext': passwordvisible,
            'error': loginerrormsg
          },
        ];
    return FutureBuilder(
      future: Future(() async {
        await mainController.autologin();
      }),
      builder: (_, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        } else {
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(tileMode: TileMode.decal, colors: [
                Colors.greenAccent.withOpacity(0.3),
                Colors.redAccent.withOpacity(0.3),
                Colors.blueAccent.withOpacity(0.3),
                Colors.yellowAccent.withOpacity(0.3)
              ])),
              child: Center(
                child: SingleChildScrollView(
                  child: GetBuilder<ThemeController>(
                      init: themeController,
                      builder: (_) => GetBuilder<MainController>(
                            init: mainController,
                            builder: (_) => Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      platformweb.kIsWeb
                                          ? Image.network(
                                              "assets/images/takamollogo.png",
                                              width: 75,
                                              height: 75,
                                            )
                                          : Image.asset(
                                              "images/takamollogo.png",
                                              width: 75,
                                              height: 75,
                                            ),
                                      ...InfoBasic.logo.map((e) =>
                                          TweenMz.translatey(
                                              durationinmilliseconds:
                                                  InfoBasic.logo.indexOf(e) *
                                                      100,
                                              begin: -100.0,
                                              end: 0.0,
                                              child: Text(
                                                e,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium,
                                              )))
                                    ],
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        themeController.chooselang(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            Lang.lang['logintitle'][Lang
                                                .langlist
                                                .indexOf(Lang.selectlanguage)],
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                          ),
                                        )
                                      ]),
                                  ...loginelements().map((e) => Visibility(
                                        visible: e['visible'],
                                        child: TextFieldMZ(
                                          readOnly: e['readonly'] ?? false,
                                          controller: e['controller'],
                                          label: e['label'],
                                          onchange: (x) => null,
                                          ontap: () => null,
                                          action: e['action'],
                                          icon: e['icon'],
                                          obscureText:
                                              e['obscuretext'] ?? false,
                                          errormsg: e['error'],
                                          textDirection:
                                              InfoBasic.textDirection(),
                                        ),
                                      )),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Visibility(
                                          visible: loginwait,
                                          child: const SizedBox(
                                              width: 100,
                                              child:
                                                  LinearProgressIndicator())),
                                      Visibility(
                                        visible: !chgpassvis,
                                        child: Visibility(
                                          visible: !loginwait,
                                          child: ElevatedButton.icon(
                                              onPressed: () async {
                                                await mainController
                                                    .checklogin();
                                              },
                                              icon: const Icon(Icons.login),
                                              label: Text(
                                                Lang.lang['loginaction'][
                                                    Lang.langlist.indexOf(
                                                        Lang.selectlanguage)],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall,
                                              )),
                                        ),
                                      ),
                                      Visibility(
                                        visible: chgpassvis,
                                        child: Visibility(
                                          visible: !loginwait,
                                          child: ElevatedButton.icon(
                                              onPressed: () async {
                                                await mainController
                                                    .chgpassaction();
                                              },
                                              icon: const Icon(Icons.login),
                                              label: Text(
                                                Lang.lang['chgpassaction'][
                                                    Lang.langlist.indexOf(
                                                        Lang.selectlanguage)],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall,
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Visibility(
                                      visible: mainloginerrormsg == null
                                          ? false
                                          : true,
                                      child: Text("$mainloginerrormsg"))
                                ]),
                          )),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
