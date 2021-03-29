import 'package:argo/src/theme/i_theme_data_rule.dart';
import 'package:argo/src/theme/theme_rule.dart';
import 'package:flutter/material.dart';

class DefaultThemeDataRule implements IThemeDataRule {
  const DefaultThemeDataRule();
  @override
  ThemeData getThemeByRule(ThemeRule rule) {
    switch (rule) {
      case ThemeRule.light:
        return ThemeData.light();
      case ThemeRule.dark:
        return ThemeData.dark();
    }
  }
}
