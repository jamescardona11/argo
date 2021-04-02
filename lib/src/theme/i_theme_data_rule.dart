import 'package:flutter/material.dart';

import 'theme_rule.dart';

/// Interface for defining my owns [ThemeRule] for have a more of two rules
mixin IThemeDataRule {
  ThemeData getThemeByRule(ThemeRule rule);
}
