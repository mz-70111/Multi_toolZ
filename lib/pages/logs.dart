import 'package:flutter/material.dart';
import 'package:multi_tools_mz/controllers/db_controller.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/bottomnavbar.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/database.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/info_basic.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/languages.dart';

class Logs extends StatelessWidget {
  const Logs({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: InfoBasic.textDirection(),
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: Text(
              "${Lang.lang['logpagetitle'][Lang.langlist.indexOf(Lang.selectlanguage)]}"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [...DB.logstable.map((e) => Text("$e"))],
          ),
        ),
        // ignore: prefer_const_constructors
        bottomNavigationBar: BottomNavBarMz(),
      )),
    );
  }
}
