import 'package:shared_preferences/shared_preferences.dart';

class SharedPreMz {
  static late SharedPreferences sharedPreference;
  static sharedPreMzSetMode({mode}) async {
    await sharedPreference.setString('mode', mode ?? 'light');
  }

  static sharedPreMzGetGetMode() async {
    sharedPreference.getString('mode');
  }

  static sharedPreMzSetLang({lang}) async {
    await sharedPreference.setString('lang', lang ?? 'light');
  }

  static sharedPreMzGetGetLang() async {
    sharedPreference.getString('lang');
  }
}
