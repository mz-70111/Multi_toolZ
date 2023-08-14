import 'package:flutter/material.dart';

class ThemeMz {
  static String? mode;
  static ThemeData lighttheme = ThemeData(
      primaryColor: Colors.white,
      textTheme: const TextTheme(
          labelMedium: TextStyle(fontFamily: "Marhey", fontSize: 15)));
  static ThemeData darktheme = ThemeData(
      primaryColor: Colors.red,
      textTheme: const TextTheme(
          labelMedium: TextStyle(fontFamily: "Marhey", fontSize: 15)));
  static ThemeData theme() => mode == 'light' ? lighttheme : darktheme;
}
