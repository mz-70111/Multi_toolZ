import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_tools_mz/controllers/main_controller.dart';
import 'package:multi_tools_mz/controllers/theme_controller.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/languages.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/textfield_mz.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});
  static TextEditingController usernamecontroller = TextEditingController();
  static TextEditingController passwordcontroller = TextEditingController();
  static bool passwordvisible = true;
  static IconData iconvisible = Icons.visibility_off;
  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.find();
    MainController mainController = Get.find();
    List loginelements() => [
          {
            'label': Lang.lang['logineusernamelabel']
                [Lang.langlist.indexOf(Lang.selectlanguage)],
            'controller': usernamecontroller,
            'icon': Icons.person,
            'action': () => null,
          },
          {
            'label': Lang.lang['loginepasswordlabel']
                [Lang.langlist.indexOf(Lang.selectlanguage)],
            'controller': usernamecontroller,
            'icon': iconvisible,
            'action': () => mainController.hideshowpasswordLogin(),
            'obscuretext': passwordvisible
          }
        ];
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: GetBuilder<ThemeController>(
              init: themeController,
              builder: (_) => GetBuilder<MainController>(
                    init: mainController,
                    builder: (_) =>
                        Column(mainAxisSize: MainAxisSize.min, children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DropdownButton(
                                focusColor: Colors.transparent,
                                icon: const Icon(Icons.language),
                                value: Lang.selectlanguage,
                                items: Lang.langlist
                                    .map((e) => DropdownMenuItem(
                                        value: "$e", child: Text("$e")))
                                    .toList(),
                                onChanged: (x) {
                                  themeController.changelang(x: x);
                                }),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(Lang.lang['logintitle']
                                  [Lang.langlist.indexOf(Lang.selectlanguage)]),
                            )
                          ]),
                      ...loginelements().map((e) => TextFieldMZ(
                            label: e['label'],
                            onchange: (x) => null,
                            ontap: () => null,
                            action: e['action'],
                            icon: e['icon'],
                            obscureText: e['obscuretext'] ?? false,
                          ))
                    ]),
                  )),
        ),
      ),
    );
  }
}
