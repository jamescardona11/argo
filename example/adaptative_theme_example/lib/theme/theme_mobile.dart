import 'package:argo/argo.dart';
import 'package:flutter/material.dart';

class MyThemesApp with IThemeDataRule {
  @override
  ThemeData getThemeByRule(ThemeRule rule) {
    switch (rule) {
      case ThemeRule.light:
        return ThemeData.dark();
      case ThemeRule.dark:
        return ThemeData.dark();
      case ThemeRule.custom:
        return ThemeData.dark();
    }
  }

  final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.blue,
    brightness: Brightness.light,
  );

  final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.grey,
    brightness: Brightness.dark,
  );

  static final ThemeData darkerTheme = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.dark,
  );
}
