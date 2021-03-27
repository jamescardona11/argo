import 'package:flutter/material.dart';

import 'theme_rule.dart';

//Interface
abstract class IThemeDataRule {
  ThemeData getThemeByRule(ThemeRule rule);
}

class DefaultThemeDataRure implements IThemeDataRule {
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
