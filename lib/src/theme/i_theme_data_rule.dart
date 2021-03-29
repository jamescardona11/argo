import 'package:flutter/material.dart';

import 'theme_rule.dart';

//Interface
abstract class IThemeDataRule {
  ThemeData getThemeByRule(ThemeRule rule);
}
