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
import 'package:intl/intl.dart' as df;

class Logs extends StatelessWidget {
  const Logs({super.key});
  static double datevalue1 = 0.0;
  static double datevalue2 = 0.0;
  static List datelist = [];
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
            datelist.clear();
            for (var i in DB.logstable) {
              datelist.contains(df.DateFormat("yyyy-MM-dd")
                      .format(DateTime.parse(i['logdate'])))
                  ? null
                  : datelist.add(df.DateFormat("yyyy-MM-dd")
                      .format(DateTime.parse(i['logdate'])));
            }
            datevalue1 = 0.0;
            datevalue2 = datelist.length - 1.toDouble();
            return Directionality(
              textDirection: InfoBasic.textDirection(),
              child: SafeArea(
                child: Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text(Lang.lang['logpagetitle']
                        [Lang.langlist.indexOf(Lang.selectlanguage)]),
                    leading: IconButton(
                        onPressed: () => mainController.navbaraction(
                            x: HomePage.lastpageindex),
                        icon: const Icon(Icons.arrow_back)),
                  ),
                  body: SingleChildScrollView(
                    child: GetBuilder<MainController>(
                      init: mainController,
                      builder: (_) => SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFieldMZ(
                                textDirection: InfoBasic.textDirection(),
                                label: Lang.lang['search'][
                                    Lang.langlist.indexOf(Lang.selectlanguage)],
                                onchange: (x) => mainController.search(
                                    firstdate: datelist[datevalue1.toInt()],
                                    lastdate: datelist[datevalue2.toInt()],
                                    datelist: DB.logstable,
                                    columnname: 'logdate',
                                    word: x,
                                    list: DB.logstable,
                                    range: ['log']),
                                action: () => null,
                                ontap: () => null),
                            DB.logstable.isNotEmpty
                                ? Column(children: [
                                    Slider(
                                        label:
                                            "${datelist[datevalue1.toInt()]}",
                                        min: 0.0,
                                        max: datelist.length - 1.toDouble(),
                                        divisions: datelist.length > 1
                                            ? datelist.length - 1
                                            : datelist.length,
                                        value: datevalue1,
                                        onChanged: (x) =>
                                            mainController.setdate1(
                                                x: x,
                                                mainlist: DB.logstable,
                                                sublist: datelist,
                                                columnname: 'logdate',
                                                y: Logs.datevalue2)),
                                    Slider(
                                        label:
                                            "${datelist[datevalue2.toInt()]}",
                                        min: 0.0,
                                        max: datelist.length - 1.toDouble(),
                                        divisions: datelist.length > 1
                                            ? datelist.length - 1
                                            : datelist.length,
                                        value: datevalue2,
                                        onChanged: (x) =>
                                            mainController.setdate2(
                                                x: x,
                                                mainlist: DB.logstable,
                                                sublist: datelist,
                                                columnname: 'logdate',
                                                y: Logs.datevalue1)),
                                  ])
                                : SizedBox(),
                            Divider(),
                            ...DB.logstable
                                .where((element) => element['visible'] == true)
                                .map((e) {
                              return Directionality(
                                textDirection: TextDirection.ltr,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("${e['log_id']}"),
                                    ),
                                    Expanded(
                                        child: SelectableText("${e['log']}")),
                                    Expanded(
                                        child:
                                            SelectableText("${e['logdate']}")),
                                  ],
                                ),
                              );
                            }),
                            Divider()
                          ],
                        ),
                      ),
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  bottomNavigationBar: BottomNavBarMz(),
                ),
              ),
            );
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
        },
      ),
    );
  }
}
