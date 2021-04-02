import 'package:adaptative_theme_example/theme/common_data.dart';
import 'package:argo/argo.dart';
import 'package:flutter/material.dart';

class MyThemesApp with IThemeDataRule {
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
    primaryColor: Colors.blueGrey,
    brightness: Brightness.light,
    textTheme: TextTheme(
      headline1: headline1.copyWith(fontSize: 26),
      headline2: headline2.copyWith(fontSize: 18),
    ),
  );

  final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.grey,
    brightness: Brightness.dark,
    textTheme: TextTheme(
      headline1: headline1.copyWith(fontSize: 26),
      headline2: headline2.copyWith(fontSize: 18),
    ),
  );

  final ThemeData darkerTheme = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    textTheme: TextTheme(
      headline1: headline1.copyWith(fontSize: 26),
      headline2: headline2.copyWith(fontSize: 18),
    ),
  );
}
