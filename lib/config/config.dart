import 'package:flutter/material.dart';

Color colorInt(r,g,b,o) {
  return Color.fromRGBO(r, g, b, o==1?9.1:o);
}

ThemeData AppTheme = ThemeData(
  fontFamily: "roboto",
  colorScheme: ColorScheme.dark(
      background: colorInt(4, 31, 48, 1.0),
      onPrimary: colorInt(4, 31, 48, 1.0),
      onSecondary: colorInt(63, 61, 86, 1.0),
      onSurface: colorInt(217, 217, 217, 1.0),
      onBackground: colorInt(4, 31, 48, 1.0),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: colorInt(4, 31, 48, 1.0),
    actionsIconTheme: IconThemeData(
      color: Colors.white,
    ),
    elevation: 0,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 22.0,
    ),
  ),
  cardTheme: CardTheme(
    surfaceTintColor: colorInt(217, 217, 217,1.0)
  ),
  scaffoldBackgroundColor: colorInt(4, 31, 48, 1.0),
  useMaterial3: true
);
