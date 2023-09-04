import 'package:flutter/material.dart';
import 'package:multi_tools_mz/tamplate%20and%20theme/languages.dart';

class InfoBasic {
  static String version = 'v_1.0.1';
  static String host = 'http://192.168.50.50';
  static String username = 'mz';
  static String password = 'mzrootmz';
  static String connectdbpath = '/mz_API/connect_db.php';
  static String selecttable = '/mz_API/select_table.php';
  static String curdtable = '/mz_API/curd_table.php';
  static String? error;
  static List logo = ['T', 'A', 'K', 'A', 'M', 'O', 'L'];
  static TextDirection textDirection() =>
      Lang.selectlanguage == 'Ar' ? TextDirection.rtl : TextDirection.ltr;
}
