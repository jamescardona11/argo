import 'package:argo/argo.dart';
import 'package:flutter/material.dart';

import 'common_data.dart';

class MyThemesWeb with IThemeDataRule {
  @override
  ThemeData getThemeByRule(ThemeRule rule) {
    switch (rule) {
      case ThemeRule.light:
        return lightTheme;
      case ThemeRule.dark:
        return darkTheme;
      case ThemeRule.custom:
        return darkerTheme;

      default:
        return lightTheme;
    }
  }

  final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.blue,
    brightness: Brightness.light,
    textTheme: TextTheme(
      headline1: headline1.copyWith(fontSize: 86, color: Colors.white),
      headline2: headline2.copyWith(fontSize: 38),
    ),
  );

  final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.grey,
    brightness: Brightness.dark,
    textTheme: TextTheme(
      headline1: headline1.copyWith(fontSize: 86, color: Colors.white),
      headline2: headline2.copyWith(fontSize: 38),
    ),
  );

  final ThemeData darkerTheme = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    textTheme: TextTheme(
      headline1: headline1.copyWith(fontSize: 86, color: Colors.white),
      headline2: headline2.copyWith(fontSize: 38),
    ),
  );
}
