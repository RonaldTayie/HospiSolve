import 'package:flutter/material.dart';

const String NotificationChannelName = "Hospisolve Counter Notification Channel";
const String NotificationChannelKey = "Hospisolve_Counter_Notification_Channel";
const String CounterNotification = "Counter Notification";

Color colorInt(r, g, b, o) {
  return Color.fromRGBO(r, g, b, o);
}

ThemeData AppTheme = ThemeData(
  fontFamily: "roboto",
  colorScheme: const ColorScheme.dark(
    background: Color.fromRGBO(4, 31, 48, .9),
    onPrimary: Color.fromRGBO(4, 31, 48, 1.0),
    onSecondary: Color.fromRGBO(63, 61, 86, 1.0),
    onSurface: Color.fromRGBO(217, 217, 217, 1.0),
    onBackground: Color.fromRGBO(4, 31, 48, 1.0),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromRGBO(4, 31, 48, 1.0),
    actionsIconTheme: IconThemeData(
      color: Colors.white,
    ),
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 22.0,
    ),
  ),
  cardTheme: const CardTheme(
    surfaceTintColor: Color.fromRGBO(217, 217, 217, 1.0),
  ),
  scaffoldBackgroundColor: const Color.fromRGBO(4, 31, 48, 1.0),
  useMaterial3: true,
);


// Networking:

const String host = "102.130.122.150:4000";
