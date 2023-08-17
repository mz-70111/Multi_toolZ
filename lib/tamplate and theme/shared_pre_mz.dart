import 'package:shared_preferences/shared_preferences.dart';

class SharedPreMz {
  static late SharedPreferences sharedPreferenceMM;
  static sharedPreMzSetMode({mode}) async {
    await sharedPreferenceMM.setString('mode', mode ?? 'light');
  }

  static sharedPreMzGetMode() {
    return sharedPreferenceMM.getString('mode');
  }

  static sharedPreMzSetLang({lang}) async {
    await sharedPreferenceMM.setString('lang', lang ?? 'light');
  }

  static sharedPreMzGetLang() {
    return sharedPreferenceMM.getString('lang');
  }

  static sharedPreMzSetLogin({List<String>? login}) async {
    await sharedPreferenceMM.setStringList('login', login!);
  }

  static sharedPreMzGetLogin() {
    return sharedPreferenceMM.getStringList('login');
  }
}
