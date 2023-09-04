import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_tools_mz/controllers/main_controller.dart';
import 'package:multi_tools_mz/pages/login.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/bottomnavbar.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/database.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/info_basic.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/languages.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/textfield_mz.dart';

class DialogMz {
  static bool wait = false, textfieldvisible = true, action2visible = false;
  static String? errormsg;
  static bool obscureText = true;
  static List selectedlist = [];
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

  static showpersonalinfoDialog({ctx}) {
    TextEditingController fullname = TextEditingController(
        text: DB.userinfotable[0]['users'][DB.userinfotable[0]['users']
                        .indexWhere((element) => element['user_id'] == LogIn.userinfo![2])]
                    ['fullname'] ==
                'null'
            ? ''
            : DB.userinfotable[0]['users'][DB.userinfotable[0]['users']
                    .indexWhere((element) => element['user_id'] == LogIn.userinfo![2])]
                ['fullname']);
    TextEditingController mobile = TextEditingController(
        text: DB.userinfotable[0]['users'][DB.userinfotable[0]['users']
                        .indexWhere((element) => element['user_id'] == LogIn.userinfo![2])]
                    ['mobile'] ==
                'null'
            ? ''
            : DB.userinfotable[0]['users'][DB.userinfotable[0]['users']
                    .indexWhere((element) => element['user_id'] == LogIn.userinfo![2])]
                ['mobile']);
    TextEditingController email = TextEditingController(
        text: DB.userinfotable[0]['users'][DB.userinfotable[0]['users']
                        .indexWhere((element) => element['user_id'] == LogIn.userinfo![2])]
                    ['email'] ==
                'null'
            ? ''
            : DB.userinfotable[0]['users'][DB.userinfotable[0]['users']
                    .indexWhere((element) => element['user_id'] == LogIn.userinfo![2])]
                ['email']);
    List textfieldmz() => [
          {
            'controller': fullname,
            'icon': Icons.person,
            'label': Lang.lang['fullname']
                [Lang.langlist.indexOf(Lang.selectlanguage)],
          },
          {
            'controller': mobile,
            'icon': Icons.phone,
            'label': Lang.lang['mobile']
                [Lang.langlist.indexOf(Lang.selectlanguage)],
          },
          {
            'controller': email,
            'icon': Icons.email,
            'label': Lang.lang['email']
                [Lang.langlist.indexOf(Lang.selectlanguage)],
          },
        ];
    List actionrow() => [
          {
            'widget': ElevatedButton(
                onPressed: () async {
                  await mainController.updatepesonalinfo(
                      fullname: fullname.text,
                      mobile: mobile.text,
                      email: email.text);
                },
                child: const Icon(Icons.save)),
            'visible': !wait,
          },
          {
            'widget': ElevatedButton(
                onPressed: () {
                  Get.back();
                  wait = false;
                },
                child: const Icon(Icons.cancel)),
            'visible': true,
          },
          {
            'widget': const SizedBox(
              width: 100,
              child: LinearProgressIndicator(),
            ),
            'visible': wait,
          }
        ];
    List maindept() => [
          {
            'label': Lang.lang['basicinfo']
                [Lang.langlist.indexOf(Lang.selectlanguage)],
            'action': () => mainController.chooseselectedinfo(0),
            'index': 0,
            'icon': Icons.info
          },
          {
            'label': Lang.lang['basicpriv']
                [Lang.langlist.indexOf(Lang.selectlanguage)],
            'action': () => mainController.chooseselectedinfo(1),
            'index': 1,
            'icon': Icons.accessibility_new
          },
          {
            'label': Lang.lang['officepriv']
                [Lang.langlist.indexOf(Lang.selectlanguage)],
            'action': () => mainController.chooseselectedinfo(2),
            'index': 2,
            'icon': Icons.work
          },
        ];
    List basicpriv = [
      DB.userinfotable[0]['users_privileges'][0]['mustchgpass'] == '1'
          ? Lang.lang['mustchgpass'][Lang.langlist.indexOf(Lang.selectlanguage)]
          : 0,
      DB.userinfotable[0]['users_privileges'][0]['enable'] == '1'
          ? Lang.lang['enable1'][Lang.langlist.indexOf(Lang.selectlanguage)]
          : 0,
      DB.userinfotable[0]['users_privileges'][0]['admin'] == '1'
          ? Lang.lang['admin'][Lang.langlist.indexOf(Lang.selectlanguage)]
          : 0,
      DB.userinfotable[0]['users_privileges'][0]['pbx'] == '1'
          ? Lang.lang['pbxaccess'][Lang.langlist.indexOf(Lang.selectlanguage)]
          : 0,
    ];
    List privatoffice(item) => [
          item['addtodo'] == '1'
              ? Lang.lang['addtodo'][Lang.langlist.indexOf(Lang.selectlanguage)]
              : 0,
          item['addremind'] == '1'
              ? Lang.lang['addremind']
                  [Lang.langlist.indexOf(Lang.selectlanguage)]
              : 0,
          item['addtask'] == '1'
              ? Lang.lang['addtask'][Lang.langlist.indexOf(Lang.selectlanguage)]
              : 0,
          item['addemailtest'] == '1'
              ? Lang.lang['addemailtest']
                  [Lang.langlist.indexOf(Lang.selectlanguage)]
              : 0,
        ];
    errormsg = null;
    return showDialog(
        context: ctx,
        builder: (_) {
          selectedlist.clear();
          for (var i = 0; i < maindept().length; i++) {
            if (i == 0) {
              selectedlist.add(true);
            } else {
              selectedlist.add(false);
            }
          }
          return Directionality(
              textDirection: InfoBasic.textDirection(),
              child: GetBuilder<MainController>(
                  init: mainController,
                  builder: (_) {
                    return AlertDialog(
                      scrollable: true,
                      title: Text(
                        Lang.lang['personalinfo']
                            [Lang.langlist.indexOf(Lang.selectlanguage)],
                      ),
                      content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: maindept().length * 60,
                              width: MediaQuery.of(ctx).size.width < 500
                                  ? MediaQuery.of(ctx).size.width
                                  : 500,
                              child: GridView.builder(
                                  itemCount: maindept().length,
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                          mainAxisExtent: 60,
                                          maxCrossAxisExtent: MediaQuery.of(ctx)
                                                      .size
                                                      .width <
                                                  500
                                              ? MediaQuery.of(ctx).size.width
                                              : 500),
                                  itemBuilder: (_, x) {
                                    return Card(
                                        elevation: 10,
                                        shadowColor: selectedlist[maindept()[x]
                                                    ['index']] ==
                                                true
                                            ? Colors.deepOrangeAccent
                                            : Colors.grey.withOpacity(0.1),
                                        child: TextButton.icon(
                                          icon: Icon(maindept()[x]['icon']),
                                          onPressed: maindept()[x]['action'],
                                          label: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Text(
                                                  maindept()[x]['label'],
                                                  style: Theme.of(ctx)
                                                      .textTheme
                                                      .titleMedium,
                                                  overflow: TextOverflow.fade,
                                                ),
                                              )),
                                        ));
                                  }),
                            ),
                            Visibility(
                                visible: selectedlist[0],
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${Lang.lang['id'][Lang.langlist.indexOf(Lang.selectlanguage)]}: ${DB.userinfotable[0]['users'][0]['user_id']} ",
                                    ),
                                    Text(
                                        "${Lang.lang['username'][Lang.langlist.indexOf(Lang.selectlanguage)]}: ${DB.userinfotable[0]['users'][0]['username']}"),
                                    ...textfieldmz().map((e) => TextFieldMZ(
                                          label: e['label'],
                                          onchange: (x) => null,
                                          action: () => null,
                                          ontap: () => null,
                                          controller: e['controller'],
                                          icon: e['icon'],
                                        ))
                                  ],
                                )),
                            Visibility(
                                visible: selectedlist[1],
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ...basicpriv
                                        .where((element) => element != 0)
                                        .map((e) => Text("* $e"))
                                  ],
                                )),
                            Visibility(
                                visible: selectedlist[2],
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ...DB.userinfotable[0]['users_priv_office']
                                        .map((e) {
                                      int index(table, idname) =>
                                          DB.allofficeinfotable[0][table]
                                              .indexWhere((element) =>
                                                  element[idname] ==
                                                  e['upo_office_id']);
                                      return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "${DB.allofficeinfotable[0]['office'][index('office', 'office_id')]['officename']}"),
                                            const Divider(),
                                            Text(
                                                "${DB.allofficeinfotable[0]['users_priv_office'][index('users_priv_office', 'upo_office_id')]['position']}"),
                                            ...privatoffice(e)
                                                .where(
                                                    (element) => element != 0)
                                                .map((e) => Text("* $e")),
                                            Divider()
                                          ]);
                                    })
                                  ],
                                )),
                            Visibility(
                                visible: errormsg == null ? false : true,
                                child: Text("$errormsg")),
                          ]),
                      actions: [
                        ...actionrow()
                            .where((e) => e['visible'] == true)
                            .map((e) => e['widget'])
                      ],
                    );
                  }));
        });
  }

  static addedit(
      {ctx, maintitle, required List maindept, type = 'add', action}) {
    List actionrow() => [
          {
            'widget': ElevatedButton(
                onPressed: action,
                child: Text(Lang.lang[type == 'add' ? 'add' : 'save']
                    [Lang.langlist.indexOf(Lang.selectlanguage)])),
            'visible': !wait,
          },
          {
            'widget': ElevatedButton(
                onPressed: () {
                  Get.back();
                  wait = false;
                },
                child: Text(Lang.lang['cancle']
                    [Lang.langlist.indexOf(Lang.selectlanguage)])),
            'visible': true,
          },
          {
            'widget': const SizedBox(
              width: 100,
              child: LinearProgressIndicator(),
            ),
            'visible': wait,
          }
        ];
    errormsg = null;
    showDialog(
        context: ctx,
        builder: (_) {
          selectedlist.clear();
          for (var i = 0; i < maindept.length; i++) {
            if (i == 0) {
              selectedlist.add(true);
            } else {
              selectedlist.add(false);
            }
          }
          return Directionality(
              textDirection: InfoBasic.textDirection(),
              child: GetBuilder<MainController>(
                  init: mainController,
                  builder: (_) {
                    return AlertDialog(
                      scrollable: true,
                      content: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: MediaQuery.of(ctx).size.width < 500
                                  ? 0
                                  : 1,
                              child: SizedBox()),
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      maintitle,
                                      style: Theme.of(ctx)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    Divider(),
                                    SizedBox(
                                      height: maindept.length /
                                                  (MediaQuery.of(ctx)
                                                          .size
                                                          .width /
                                                      500)
                                              *
                                          60,
                                      width: MediaQuery.of(ctx)
                                                  .size
                                                  .width <
                                              500
                                          ? MediaQuery.of(ctx).size.width
                                          : 500,
                                      child: GridView.builder(
                                          itemCount: maindept.length,
                                          gridDelegate:
                                              SliverGridDelegateWithMaxCrossAxisExtent(
                                                  mainAxisExtent: 60,
                                                  maxCrossAxisExtent:
                                                      MediaQuery.of(ctx)
                                                                  .size
                                                                  .width <
                                                              500
                                                          ? MediaQuery.of(
                                                                  ctx)
                                                              .size
                                                              .width
                                                          : 400),
                                          itemBuilder: (_, x) {
                                            return Card(
                                                elevation: 10,
                                                shadowColor: selectedlist[
                                                            maindept[x][
                                                                'index']] ==
                                                        true
                                                    ? Colors.black54
                                                    : Colors.grey
                                                        .withOpacity(0.1),
                                                child: TextButton.icon(
                                                  icon: Icon(maindept[x]
                                                      ['icon']),
                                                  onPressed: maindept[x]
                                                      ['action'],
                                                  label: Padding(
                                                      padding:
                                                          const EdgeInsets
                                                              .all(8.0),
                                                      child: Text(
                                                        maindept[x]
                                                            ['label'],
                                                        style: Theme.of(
                                                                ctx)
                                                            .textTheme
                                                            .titleMedium,
                                                        overflow:
                                                            TextOverflow
                                                                .fade,
                                                      )),
                                                ));
                                          }),
                                    ),
                                    ...maindept
                                        .where((element) =>
                                            selectedlist[
                                                element['index']] ==
                                            true)
                                        .map((m) => m['widget']),
                                    Visibility(
                                        visible: errormsg == null
                                            ? false
                                            : true,
                                        child: Text("$errormsg")),
                                
                                  ]),
                            ),
                          ),
                          Expanded(
                              flex: MediaQuery.of(ctx).size.width < 500
                                  ? 0
                                  : 1,
                              child: SizedBox()),
                        ],
                      ),
                      actions: [...actionrow()
                                                    .where((e) =>
                                                        e['visible'] == true)
                                                    .map((e) => Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .all(8.0),
                                                        child: e['widget']))],
                    );
                  }));
        });
  }
}
