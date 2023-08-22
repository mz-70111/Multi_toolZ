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
      iconTheme: const IconThemeData(color: Colors.yellowAccent),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          backgroundColor: Colors.yellow.withOpacity(0.5)),
      elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.black26))),
      textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontFamily: "Marhey", fontSize: 17, color: Colors.white60),
          titleMedium: TextStyle(
              fontFamily: "Marhey", fontSize: 15, color: Colors.white60),
          titleSmall: TextStyle(
              fontFamily: "Marhey", fontSize: 10, color: Colors.white60),
          labelMedium: TextStyle(
              fontFamily: "Marhey", fontSize: 20, color: Colors.yellowAccent),
          labelSmall: TextStyle(
              fontFamily: "Marhey", fontSize: 13, color: Colors.white)));

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
      iconTheme: const IconThemeData(color: Colors.deepPurple),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          backgroundColor: Colors.indigo.withOpacity(0.5)),
      elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.white))),
      textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontFamily: "Marhey", fontSize: 17, color: Colors.black),
          titleMedium: TextStyle(
              fontFamily: "Marhey", fontSize: 15, color: Colors.black),
          titleSmall: TextStyle(
              fontFamily: "Marhey", fontSize: 10, color: Colors.black),
          labelMedium: TextStyle(
              fontFamily: "Marhey", fontSize: 20, color: Colors.indigo),
          labelSmall: TextStyle(
              fontFamily: "Marhey", fontSize: 13, color: Colors.black)));
}
