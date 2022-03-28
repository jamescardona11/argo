import 'package:flutter/material.dart';

import 'i_theme_data_rule.dart';
import 'theme_rule.dart';

/// {@template default_theme_data}
///
/// Class that defines the default theme, this is used to avoid `NullPointerException`
/// must return a `ThemeData`.
///
/// {@endtemplate}
class DefaultThemeDataRule with IThemeDataRule {
  const DefaultThemeDataRule();

  @override
  ThemeData getThemeByRule([ThemeRule rule = ThemeRule.light]) {
    return ThemeData.light();
  }
}
