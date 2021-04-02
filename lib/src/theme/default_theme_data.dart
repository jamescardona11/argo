import 'package:flutter/material.dart';

import 'i_theme_data_rule.dart';
import 'theme_rule.dart';

class DefaultThemeDataRule implements IThemeDataRule {
  const DefaultThemeDataRule();
  @override
  ThemeData getThemeByRule(ThemeRule rule) {
    return ThemeData.light();
  }
}
