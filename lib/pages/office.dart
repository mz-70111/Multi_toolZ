import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_tools_mz/controllers/db_controller.dart';
import 'package:multi_tools_mz/controllers/main_controller.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/bottomnavbar.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/database.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/dialogmz.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/dropmz.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/info_basic.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/languages.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/textfield_mz.dart';

class Office extends StatelessWidget {
  const Office({super.key});
  static TextEditingController officenamecontroller = TextEditingController();
  static TextEditingController officechatidcontroller = TextEditingController();
  static TextEditingController searchcontroller = TextEditingController();

  static List<Map> offmem = [];
  static List<Map> priv = [];
  static int ee = 0;
  static bool moreitemsshow = false;
  static bool notifi = false;
  static List moreitems = [];

  @override
  Widget build(BuildContext context) {
    DBController dbController = Get.find();
    List maindept(widgetlist) => [
          {
            'label': Lang.lang['basicinfo']
                [Lang.langlist.indexOf(Lang.selectlanguage)],
            'action': () => mainController.chooseselectedinfo(0),
            'index': 0,
            'icon': Icons.info,
            'widget': widgetlist[0]
          },
          {
            'label': Lang.lang['officemembers']
                [Lang.langlist.indexOf(Lang.selectlanguage)],
            'action': () => mainController.chooseselectedinfo(1),
            'index': 1,
            'icon': Icons.people,
            'widget': widgetlist[1]
          },
        ];
    List tf = [
      {
        'controller': officenamecontroller,
        'icon': Icons.work,
        'label': Lang.lang['officename']
            [Lang.langlist.indexOf(Lang.selectlanguage)],
      },
      {
        'controller': officechatidcontroller,
        'icon': Icons.chat_bubble,
        'label': Lang.lang['officechatid']
            [Lang.langlist.indexOf(Lang.selectlanguage)],
      },
    ];
    Widget textfieldmz({e}) {
      if (e != null) {
        officenamecontroller.text = e['officename'];
        officechatidcontroller.text = e['chatid'];
        notifi = e['notifi'] == "1" ? true : false;
      } else {
        officechatidcontroller.text = officenamecontroller.text = '';
        notifi = false;
      }
      return GetBuilder<MainController>(
          init: mainController,
          builder: (_) => Column(children: [
                ...tf.map((e) => TextFieldMZ(
                    label: e['label'],
                    icon: e['icon'],
                    controller: e['controller'],
                    onchange: (x) => null,
                    action: () => null,
                    ontap: () => null)),
                Row(
                  children: [
                    Switch(
                        value: notifi,
                        onChanged: (x) => mainController.setnotifi(x)),
                    Text(
                      Lang.lang['notifi']
                          [Lang.langlist.indexOf(Lang.selectlanguage)],
                    )
                  ],
                )
              ]));
    }

    Widget officemembers({e}) {
      if (e != null) {
        offmem.clear();
        offmem.add({
          'widget': TextFieldMZ(
            label: Lang.lang['search']
                [Lang.langlist.indexOf(Lang.selectlanguage)],
            onchange: (x) => mainController.searchindropMz(
                list: offmem, range: ['name'], word: x),
            action: () => null,
            ontap: () => null,
            controller: searchcontroller,
          ),
          'visiblesearch': true,
          'visible': true
        });
        List alreadyusers = [];
        print(DB.allofficeinfotable);

        for (var i in DB.allofficeinfotable[0]['users_priv_office']
            .where((r) => r['upo_office_id'] == e['office_id'])) {
          alreadyusers.add(i['upo_user_id']);
          offmem.add({
            'widget': Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(DB.allusersinfotable[0]['users'][DB.allusersinfotable[0]
                            ['users']
                        .indexWhere((r) => r['user_id'] == i['upo_user_id'])]
                    ['fullname'])
              ],
            ),
            'visible': false,
            'visiblesearch': true,
            'name': DB.allusersinfotable[0]['users']
                [DB.allusersinfotable[0]
                            ['users']
                        .indexWhere((r) => r['user_id'] == i['upo_user_id'])]['fullname'],
            'user_id': i['upo_user_id'],
            'Position': i['position'],
            'Po-employee': 'employee',
            'Po-supervisor': 'supervisor',
            'P-addtask': i['addtask'] == "1" ? true : false,
            'P-addouttask': i['addouttask'] == "1" ? true : false,
            'P-addtodo': i['addtodo'] == "1" ? true : false,
            'P-addremind': i['addremind'] == "1" ? true : false,
            'P-addemailtest': i['addemailtest'] == "1" ? true : false,
            'P-addping': i['addping'] == "1" ? true : false,
          });
        }
        print(alreadyusers);

        for (var i in DB.allusersinfotable[0]['users']
            .where((r) => !alreadyusers.contains(r['user_id']))) {
          offmem.add({
            'widget': Row(
              mainAxisSize: MainAxisSize.min,
              children: [Icon(Icons.add), Text(i['fullname'])],
            ),
            'visible': true,
            'visiblesearch': true,
            'name': i['fullname'],
            'user_id': i['user_id'],
            'Position': 'employee',
            'Po-employee': 'employee',
            'Po-supervisor': 'supervisor',
            'P-addtask': false,
            'P-addouttask': false,
            'P-addtodo': false,
            'P-addremind': false,
            'P-addemailtest': false,
            'P-addping': false
          });
        }
      } else {
        offmem.clear();
        offmem.add({
          'widget': TextFieldMZ(
            label: Lang.lang['search']
                [Lang.langlist.indexOf(Lang.selectlanguage)],
            onchange: (x) => mainController.searchindropMz(
                list: offmem, range: ['name'], word: x),
            action: () => null,
            ontap: () => null,
            controller: searchcontroller,
          ),
          'visiblesearch': true,
          'visible': true
        });
        for (var i in DB.allusersinfotable[0]['users']) {
          offmem.add({
            'widget': Row(
              mainAxisSize: MainAxisSize.min,
              children: [Icon(Icons.add), Text(i['fullname'])],
            ),
            'visible': true,
            'visiblesearch': true,
            'name': i['fullname'],
            'user_id': i['user_id'],
            'Position': 'employee',
            'Po-employee': 'employee',
            'Po-supervisor': 'supervisor',
            'P-addtask': false,
            'P-addouttask': false,
            'P-addtodo': false,
            'P-addremind': false,
            'P-addemailtest': false,
            'P-addping': false
          });
        }
      }

      return GetBuilder<MainController>(
        init: mainController,
        builder: (_) => SizedBox(
          width: MediaQuery.of(context).size.width < 500
              ? MediaQuery.of(context).size.width
              : 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              ...offmem.where((r) => r['visible'] == false).map((e) => Padding(
                  padding: EdgeInsetsDirectional.all(8.0),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      child: Text(e['name']),
                      onTap: () => setprivatoffice(
                        ctx: context,
                        remove: true,
                      ),
                    ),
                  ))),
              Divider(),
              DropMz(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      Lang.lang['addmember']
                          [Lang.langlist.indexOf(Lang.selectlanguage)],
                    ),
                  ),
                  items: [
                    ...offmem.where((element) =>
                        element['visible'] == true &&
                        element['visiblesearch'] == true)
                  ],
                  item: 'widget',
                  onchange: (e) {
                    ee = offmem.indexOf(e);
                    return setprivatoffice(ctx: context);
                  }),
              Divider()
            ],
          ),
        ),
      );
    }

    Widget moreitemMz(e) {
      for (var i in DB.allofficeinfotable[0]['office']) {
        Office.moreitems.add([
          {
            'w': Icon(Icons.delete_forever),
            'stackup': 0,
            't': Text(Lang.lang['remove']
                [Lang.langlist.indexOf(Lang.selectlanguage)]),
            'visible0': false,
            'visible1': false,
          },
        ]);
      }
      return Row(
        children: [
          ...moreitems[DB.allofficeinfotable[0]['office'].indexOf(e)]
              .where((element) => element['visible0'] == true)
              .map((i) => GestureDetector(
                  onTap: () {
                    i['visible1'] == false
                        ? mainController.showmoreitemsConfirm(e: e, et: i)
                        : mainController.removeoffice(officeid: e['office_id']);
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Card(
                      elevation: i['visible1'] == false ? 0 : 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [
                          i['w'],
                          Visibility(visible: i['visible1'], child: i['t'])
                        ]),
                      ),
                    ),
                  )))
        ],
      );
    }

    return GetBuilder<DBController>(
      init: dbController,
      builder: (_) => FutureBuilder(future: Future(() async {
        try {
          return DB.allofficeinfotable =
              await DBController().getallofficeinfotable();
        } catch (e) {}
      }), builder: (_, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(
                  child:
                      SizedBox(width: 100, child: LinearProgressIndicator())));
        } else if (snap.hasData) {
          return Directionality(
              textDirection: InfoBasic.textDirection(),
              child: SafeArea(
                  child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(Lang.lang['offices']
                      [Lang.langlist.indexOf(Lang.selectlanguage)]),
                ),
                body: GetBuilder<MainController>(
                    init: mainController,
                    builder: (_) => SizedBox(
                          width: double.infinity,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFieldMZ(
                                    textDirection: InfoBasic.textDirection(),
                                    label: Lang.lang['search'][Lang.langlist
                                        .indexOf(Lang.selectlanguage)],
                                    onchange: (x) => mainController.search(
                                        word: x,
                                        list: DB.allofficeinfotable[0]
                                            ['office'],
                                        range: ['officename']),
                                    action: () => null,
                                    ontap: () => null),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(children: [
                                      ...DB.allofficeinfotable[0]['office']
                                          .where(
                                              (v) => v['visiblesearch'] == true)
                                          .map((o) {
                                        return Card(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    DialogMz.addedit(
                                                        action: () async =>
                                                            await mainController
                                                                .addoffice(),
                                                        ctx: context,
                                                        maintitle: Lang.lang[
                                                                'addoffice'][
                                                            Lang.langlist
                                                                .indexOf(Lang
                                                                    .selectlanguage)],
                                                        maindept: maindept([
                                                          textfieldmz(e: o),
                                                          officemembers(e: o)
                                                        ]));
                                                  },
                                                  child: MouseRegion(
                                                    cursor: SystemMouseCursors
                                                        .click,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                              "# ${o['office_id']} _"),
                                                          Expanded(
                                                              child: Text(
                                                            o['officename'],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          )),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              moreitemMz(o),
                                              IconButton(
                                                  onPressed: () {
                                                    mainController
                                                        .showmoreitems(o);
                                                  },
                                                  icon: Icon(Icons.more_horiz)),
                                            ],
                                          ),
                                        );
                                      })
                                    ]),
                                  ),
                                )
                              ]),
                        )),
                floatingActionButton: FloatingActionButton(
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () => DialogMz.addedit(
                        action: () async => await mainController.addoffice(),
                        ctx: context,
                        maintitle: Lang.lang['addoffice']
                            [Lang.langlist.indexOf(Lang.selectlanguage)],
                        maindept: maindept([textfieldmz(), officemembers()]))),
                // ignore: prefer_const_constructors
                bottomNavigationBar: BottomNavBarMz(),
              )));
        } else {
          return Scaffold(
              body: Center(
            child: IconButton(
                onPressed: () {
                  dbController.update();
                },
                icon: const Icon(Icons.refresh)),
          ));
        }
      }),
    );
  }

  setprivatoffice({ctx, remove = false}) {
    List action(ee) => [
          {
            'visible': true,
            'widget': ElevatedButton(
                onPressed: () {
                  mainController.setpriv(index: ee, remove: true);
                },
                child: Text(Lang.lang['add']
                    [Lang.langlist.indexOf(Lang.selectlanguage)]))
          },
          {
            'visible': true,
            'widget': ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(Lang.lang['cancle']
                    [Lang.langlist.indexOf(Lang.selectlanguage)]))
          },
          {
            'visible': remove,
            'widget': ElevatedButton(
                onPressed: () {
                  mainController.setpriv(index: ee);
                },
                child: Text(Lang.lang['remove']
                    [Lang.langlist.indexOf(Lang.selectlanguage)]))
          }
        ];
    priv = [];
    for (var i in offmem.where((element) => offmem.indexOf(element) > 0)) {
      priv.add({});
      for (var t in i.keys.toList().where((element) =>
          element.contains("Po-") ||
          element.contains("Position") ||
          element.contains("P-"))) {
        priv[offmem.indexOf(i) - 1].addAll({t: offmem[offmem.indexOf(i)][t]});
      }
    }

    showDialog(
        context: ctx,
        builder: (_) {
          return Directionality(
              textDirection: InfoBasic.textDirection(),
              child: GetBuilder<MainController>(
                init: mainController,
                builder: (_) {
                  return AlertDialog(
                    scrollable: true,
                    title: Text(Lang.lang['officepriv']
                        [Lang.langlist.indexOf(Lang.selectlanguage)]),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...priv.map((p) => Column(
                              children: [
                                ...p.keys
                                    .toList()
                                    .where((q) => q.contains("Po-"))
                                    .map((r) => Row(
                                          children: [
                                            Radio(
                                                value: p[r],
                                                groupValue: p['Position'],
                                                onChanged: (x) {
                                                  mainController.radiopriv(
                                                      name: 'Position',
                                                      index: priv.indexOf(p));
                                                }),
                                            Text(Lang.lang[r.substring(3)][Lang
                                                .langlist
                                                .indexOf(Lang.selectlanguage)])
                                          ],
                                        )),
                                ...p.keys
                                    .toList()
                                    .where((q) => q.contains("P-"))
                                    .map((r) => Row(
                                          children: [
                                            Checkbox(
                                                value: p[r],
                                                onChanged: (x) {
                                                  mainController.checkboxpriv(
                                                      x: x,
                                                      name: r,
                                                      index: priv.indexOf(p));
                                                }),
                                            Text(Lang.lang[r.substring(2)][Lang
                                                .langlist
                                                .indexOf(Lang.selectlanguage)])
                                          ],
                                        ))
                              ],
                            ))
                      ],
                    ),
                    actions: [
                      ...action(ee)
                          .where((element) => element['visible'] == true)
                          .map((e) => e['widget'])
                    ],
                  );
                },
              ));
        });
  }
}
