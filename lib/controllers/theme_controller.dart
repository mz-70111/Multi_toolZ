import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_tools_mz/pages/homepage.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/bottomnavbar.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/languages.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/shared_pre_mz.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/theme_Mz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    SharedPreMz.sharedPreferenceMM = await SharedPreferences.getInstance();
    ThemeMz.mode = SharedPreMz.sharedPreMzGetMode() ?? 'light';
    Lang.selectlanguage = SharedPreMz.sharedPreMzGetLang() ?? 'Ar';
    update();
  }

  changelang({x}) async {
    Lang.selectlanguage = x;
    await SharedPreMz.sharedPreMzSetLang(lang: x);
    Lang.selectlanguage = SharedPreMz.sharedPreMzGetLang();
    update();
  }

  chooselang() {
    ThemeController themeController = Get.find();
    return DropdownButton(
        focusColor: Colors.transparent,
        icon: const Icon(Icons.language),
        value: Lang.selectlanguage,
        items: Lang.langlist
            .map((e) => DropdownMenuItem(value: "$e", child: Text("$e")))
            .toList(),
        onChanged: (x) {
          themeController.changelang(x: x);
        });
  }

  changetheme() async {
    ThemeMz.mode = ThemeMz.mode == 'light' ? 'dark' : 'light';
    await SharedPreMz.sharedPreMzSetMode(mode: ThemeMz.mode);
    ThemeMz.mode = SharedPreMz.sharedPreMzGetMode();
    HomePage.modeicon =
        HomePage.modeicon == Icons.sunny ? Icons.dark_mode : Icons.sunny;

    update();
  }
}
