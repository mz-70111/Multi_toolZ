import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_tools_mz/controllers/main_controller.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/bottomnavbar.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/info_basic.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/languages.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/textfield_mz.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/tween_mz.dart';

class DialogMz {
  static bool wait = false, textfieldvisible = true, action2visible = false;
  static String? errormsg;
  static bool obscureText = true;
  static bool selected = true;
  static chgpassfrompresonalDialog({ctx}) {
    textfieldvisible = true;
    wait = action2visible = false;
    errormsg = null;
    TextEditingController oldpasscontroller = TextEditingController();
    TextEditingController newpasscontroller = TextEditingController();
    TextEditingController confirmnewpasscontroller = TextEditingController();
    List textfieldmz() => [
          {
            'obscuretext': obscureText,
            'visible': DialogMz.textfieldvisible,
            'controller': oldpasscontroller,
            'icon': Icons.visibility_off,
            'action': () => mainController.hideshowpasswordchgpass(),
            'label': Lang.lang['loginpasswordlabel']
                [Lang.langlist.indexOf(Lang.selectlanguage)],
            'textdirection': TextDirection.ltr,
          },
          {
            'obscuretext': obscureText,
            'visible': !DialogMz.textfieldvisible,
            'controller': newpasscontroller,
            'icon': Icons.visibility_off,
            'action': () => mainController.hideshowpasswordchgpass(),
            'label': Lang.lang['loginnewpasswordlabel']
                [Lang.langlist.indexOf(Lang.selectlanguage)],
            'textdirection': TextDirection.ltr,
          },
          {
            'obscuretext': obscureText,
            'visible': !DialogMz.textfieldvisible,
            'controller': confirmnewpasscontroller,
            'icon': Icons.visibility_off,
            'action': () => mainController.hideshowpasswordchgpass(),
            'label': Lang.lang['loginnewpasswordconfirmlabel']
                [Lang.langlist.indexOf(Lang.selectlanguage)],
            'textdirection': TextDirection.ltr,
          },
        ];
    List actionrow() => [
          {
            'widget': ElevatedButton(
                onPressed: () {
                  mainController.checkpasswordforpersonal(
                      password: oldpasscontroller.text);
                },
                child: const Icon(Icons.login)),
            'visible': !wait,
            'visible2': !action2visible
          },
          {
            'widget': ElevatedButton(
                onPressed: () async =>
                    await mainController.changepasswordpersonal(
                        newpass: newpasscontroller.text,
                        newpassconfirm: confirmnewpasscontroller.text),
                child: const Icon(Icons.done)),
            'visible': !wait,
            'visible2': action2visible
          },
          {
            'widget': const SizedBox(
              width: 100,
              child: LinearProgressIndicator(),
            ),
            'visible': wait,
            'visible2': wait
          }
        ];
    return showDialog(
        context: ctx,
        builder: (_) {
          return Directionality(
            textDirection: InfoBasic.textDirection(),
            child: GetBuilder<MainController>(
              init: mainController,
              builder: (_) => AlertDialog(
                scrollable: true,
                title: Text(Lang.lang['drawerpesonalchgpass']
                    [Lang.langlist.indexOf(Lang.selectlanguage)]),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...textfieldmz()
                        .where((element) => element['visible'] == true)
                        .map((e) => TextFieldMZ(
                            icon: e['icon'],
                            obscureText: e['obscuretext'],
                            textDirection:
                                e['textdirection'] ?? InfoBasic.textDirection(),
                            label: e['label'],
                            controller: e['controller'],
                            onchange: (x) => null,
                            action: e['action'],
                            ontap: () => null)),
                    Visibility(
                        visible: errormsg == null ? false : true,
                        child: Text("$errormsg")),
                  ],
                ),
                actions: [
                  ...actionrow()
                      .where((element) =>
                          element['visible'] == true &&
                          element['visible2'] == true)
                      .map((e) => e['widget'])
                ],
              ),
            ),
          );
        });
  }

  static chgpassshowpersonalDialog({ctx}) {
    TextEditingController fullname = TextEditingController();
    TextEditingController mobile = TextEditingController();
    TextEditingController email = TextEditingController();
    List textfieldmz() => [
          {
            'visible': !DialogMz.textfieldvisible,
            'controller': fullname,
            'icon': Icons.person,
            'label': Lang.lang['fullname']
                [Lang.langlist.indexOf(Lang.selectlanguage)],
          },
          {
            'visible': !DialogMz.textfieldvisible,
            'controller': mobile,
            'icon': Icons.phone,
            'label': Lang.lang['mobile']
                [Lang.langlist.indexOf(Lang.selectlanguage)],
          },
          {
            'visible': !DialogMz.textfieldvisible,
            'controller': email,
            'icon': Icons.email,
            'label': Lang.lang['email']
                [Lang.langlist.indexOf(Lang.selectlanguage)],
          },
        ];
    List actionrow() => [
          {
            'widget':
                ElevatedButton(onPressed: () {}, child: const Icon(Icons.save)),
            'visible': !wait,
            'visible2': !action2visible
          },
          {
            'widget': ElevatedButton(
                onPressed: () => Get.back(), child: const Icon(Icons.cancel)),
            'visible': true,
            'visible2': !action2visible
          },
          {
            'widget': const SizedBox(
              width: 100,
              child: LinearProgressIndicator(),
            ),
            'visible': wait,
            'visible2': wait
          }
        ];
    List maindept(x) => [
          {
            'label': Lang.lang['basicinfo']
                [Lang.langlist.indexOf(Lang.selectlanguage)],
            'action': () => mainController.chooseselectedinfo(selected: x),
            'selected': x,
            'index': 0
          },
          {
            'label': Lang.lang['basicpriv']
                [Lang.langlist.indexOf(Lang.selectlanguage)],
            'action': () => mainController.chooseselectedinfo(selected: x),
            'selected': x,
            'index': 1
          },
          {
            'label': Lang.lang['officepriv']
                [Lang.langlist.indexOf(Lang.selectlanguage)],
            'action': () => mainController.chooseselectedinfo(selected: x),
            'selected': x,
            'index': 2
          },
        ];
    return showDialog(
        context: ctx,
        builder: (_) {
          return Directionality(
              textDirection: InfoBasic.textDirection(),
              child: GetBuilder<MainController>(
                  init: mainController,
                  builder: (_) => AlertDialog(
                      scrollable: true,
                      title: Text(
                        Lang.lang['personalinfo']
                            [Lang.langlist.indexOf(Lang.selectlanguage)],
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ...maindept(selected).map((e) => TextButton(
                                  onPressed: e['action'],
                                  child: TweenMz.scale(
                                    durationinmilliseconds: 300,
                                    end: e['selected'] == true ? 1.2 : 1,
                                    child: Card(
                                      elevation: e['selected'] == true ? 20 : 0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          e['label'],
                                          style: Theme.of(ctx)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ),
                                    ),
                                  )))
                            ],
                          )
                        ],
                      ))));
        });
  }
}
