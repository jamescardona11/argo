import 'package:flutter/material.dart';

import 'theme_rule.dart';

/// Interface for defining my owns [ThemeRule] for have a more of two rules
abstract class IThemeDataRule {
  ThemeData getThemeByRule(ThemeRule rule);
}
