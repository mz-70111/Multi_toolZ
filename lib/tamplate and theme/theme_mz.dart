import 'package:flutter/material.dart';

class ThemeMz {
  static String? mode;
  static ThemeData darktheme = ThemeData(
      colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Colors.amberAccent,
          onPrimary: Colors.yellowAccent,
          secondary: Colors.teal,
          onSecondary: Colors.blue,
          error: Colors.amberAccent,
          onError: Colors.amberAccent,
          background: Colors.yellowAccent,
          onBackground: Colors.tealAccent,
          surface: Colors.orangeAccent,
          onSurface: Colors.amber),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.black12),
      elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.black26))),
      textTheme: const TextTheme(
          labelMedium: TextStyle(
              fontFamily: "Marhey", fontSize: 20, color: Colors.yellowAccent),
          labelSmall: TextStyle(
              fontFamily: "Marhey", fontSize: 15, color: Colors.yellowAccent)));

  static ThemeData lighttheme = ThemeData(
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Colors.indigo,
          onPrimary: Colors.indigo,
          secondary: Colors.teal,
          onSecondary: Colors.blue,
          error: Colors.red,
          onError: Colors.redAccent,
          background: Colors.yellowAccent,
          onBackground: Colors.tealAccent,
          surface: Colors.orangeAccent,
          onSurface: Colors.indigoAccent),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.white70),
      elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.white60))),
      textTheme: const TextTheme(
          labelMedium: TextStyle(
              fontFamily: "Marhey", fontSize: 20, color: Colors.indigo),
          labelSmall: TextStyle(
              fontFamily: "Marhey", fontSize: 15, color: Colors.indigoAccent)));
}
