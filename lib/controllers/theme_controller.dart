import 'package:get/get.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/languages.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/shared_pre_mz.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/theme_Mz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    SharedPreMz.sharedPreference = await SharedPreferences.getInstance();
    ThemeMz.mode = await SharedPreMz.sharedPreMzGetGetMode() ?? 'light';
    Lang.selectlanguage = await SharedPreMz.sharedPreMzGetGetLang() ?? 'Ar';

    update();
  }

  changelang({x}) {
    Lang.selectlanguage = x;
    update();
  }
}
