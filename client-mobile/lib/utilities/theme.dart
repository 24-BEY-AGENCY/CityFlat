import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  AppTheme._();

  static const Color appBackgroundColor = Color.fromRGBO(255, 255, 255, 1);
  static const Color canvasColor = Color.fromRGBO(255, 255, 255, 1);
  static const Color primaryColor = Color.fromRGBO(13, 178, 84, 1);

  static const Color secondary = Color.fromRGBO(255, 255, 255, 1);

  static final ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
    unselectedWidgetColor: const Color.fromARGB(255, 86, 86, 86),
    disabledColor: const Color.fromARGB(255, 162, 162, 162),
    primaryColorLight: const Color.fromRGBO(7, 210, 95, 1),
    primaryColor: const Color.fromRGBO(2, 129, 57, 1),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: const Color.fromRGBO(13, 178, 84, 1),
      secondary: const Color.fromRGBO(255, 255, 255, 1),
      tertiary: const Color.fromARGB(255, 31, 57, 191),
      background: const Color.fromARGB(255, 255, 255, 255),
      error: const Color.fromARGB(255, 255, 17, 0),
    ),
    textTheme: lightTextTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(
          const Color.fromRGBO(255, 255, 255, 255),
        ),
        elevation: MaterialStateProperty.all(4.0),
        minimumSize: MaterialStateProperty.all(const Size(double.infinity, 45)),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );

  static const TextTheme lightTextTheme = TextTheme(
    displayLarge: _lightHeadine,
  );

  static const TextStyle _lightHeadine = TextStyle(
    color: Color.fromRGBO(255, 255, 255, 1),
    fontSize: 18,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
  );
}
