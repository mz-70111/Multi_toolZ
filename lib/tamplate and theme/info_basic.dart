import 'package:flutter/material.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/languages.dart';

class InfoBasic {
  static String version = 'v_1.0.1';
  static String host = 'http://192.168.30.8';
  static String username = 'mz';
  static String password = 'mzrootmz';
  static String connectdbpath = '/php_API/connect_db.php';
  static String customquerypath = '/php_API/custom_query.php';
  static List logo = ['T', 'A', 'K', 'A', 'M', 'O', 'L'];
  static TextDirection textDirection() =>
      Lang.selectlanguage == 'Ar' ? TextDirection.rtl : TextDirection.ltr;
}
