import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_tools_mz/controllers/db_controller.dart';
import 'package:multi_tools_mz/controllers/main_controller.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/bottomnavbar.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/database.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/dialogmz.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/info_basic.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/languages.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/textfield_mz.dart';

class Office extends StatelessWidget {
  const Office({super.key});
  static TextEditingController officenamecontroller = TextEditingController();
  static TextEditingController officechatidcontroller = TextEditingController();

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
        'widgettype': TextField,
        'index': 0
      },
      {
        'controller': officechatidcontroller,
        'icon': Icons.chat_bubble,
        'label': Lang.lang['officechatid']
            [Lang.langlist.indexOf(Lang.selectlanguage)],
        'widgettype': TextField,
        'index': 0
      },
    ];
    Widget textfieldmz() => Column(
          children: [
            ...tf.map((e) => TextFieldMZ(
                label: e['label'],
                icon: e['icon'],
                controller: e['controller'],
                onchange: (x) => null,
                action: () => null,
                ontap: () => null))
          ],
        );
    List offmem = [];
    Widget officemembers() => Column(
          children: [...offmem.map((e) => Text(e))],
        );

    return GetBuilder<DBController>(
      init: dbController,
      builder: (_) => FutureBuilder(future: Future(() async {
        return DB.allofficeinfotable =
            await DBController().getallofficeinfotable();
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
                                SingleChildScrollView(
                                    child: Column(children: [
                                  ...DB.allofficeinfotable[0]['office']
                                      .where((v) => v['visiblesearch'] == true)
                                      .map((o) {
                                    return Card(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text("# ${o['office_id']} _"),
                                          Text(o['officename']),
                                        ],
                                      ),
                                    ));
                                  })
                                ]))
                              ]),
                        )),
                floatingActionButton: FloatingActionButton(
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () => DialogMz.additemDialog(
                        ctx: context,
                        title: Lang.lang['addoffice']
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
}
