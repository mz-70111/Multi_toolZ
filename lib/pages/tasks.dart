import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_tools_mz/controllers/db_controller.dart';
import 'package:multi_tools_mz/controllers/main_controller.dart';
import 'package:multi_tools_mz/pages/homepage.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/bottomnavbar.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/database.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/info_basic.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/languages.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/textfield_mz.dart';

class Tasks extends StatelessWidget {
  const Tasks({super.key});

  @override
  Widget build(BuildContext context) {
    DBController dbController = Get.find();

    return GetBuilder<DBController>(
      init: dbController,
      builder: (_) => FutureBuilder(
          future: Future(
              () async => DB.logstable = await DBController().getlogsinfo()),
          builder: (_, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                  body: Center(
                      child: SizedBox(
                          width: 100, child: LinearProgressIndicator())));
            } else if (snap.hasData) {
              return Directionality(
                  textDirection: InfoBasic.textDirection(),
                  child: SafeArea(
                      child: Scaffold(
                    appBar: AppBar(
                      centerTitle: true,
                      title: Text(Lang.lang['tasks']
                          [Lang.langlist.indexOf(Lang.selectlanguage)]),
                    ),
                    body: SingleChildScrollView(
                        child: GetBuilder<MainController>(
                            init: mainController,
                            builder: (_) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextFieldMZ(
                                          label: Lang.lang['search'][Lang
                                              .langlist
                                              .indexOf(Lang.selectlanguage)],
                                          onchange: (x) => mainController
                                                  .search(
                                                      word: x,
                                                      list: DB.logstable,
                                                      range: [
                                                    'taskname',
                                                    'taskdetails',
                                                    'taskusers',
                                                    'taskstatus'
                                                  ]),
                                          action: () => null,
                                          ontap: () => null),
                                      Column(children: [])
                                    ]))),
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
