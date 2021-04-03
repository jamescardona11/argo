import 'package:flutter/material.dart';

import 'theme_rule.dart';

/// {@template i_theme_data_rule}
/// Mixin for defining my owns `ThemeData` for the app.
///
/// It is used to create differents `responsive theme` and through the [ThemeRule] you get the current `ThemeData`
///
/// {@endtemplate}
mixin IThemeDataRule {
  ThemeData getThemeByRule({ThemeRule rule = ThemeRule.light});
}
