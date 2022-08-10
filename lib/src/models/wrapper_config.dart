import 'package:flutter/widgets.dart';

import 'package:argo/src/theme/theme_rule.dart';
import 'package:argo/src/utils/size_by_platform.dart';
import 'screen_breakpoints.dart';

/// {@template wrapper_config}
///
/// Data class to handle the global configuration for the [ResponsiveWrapper]
/// Helps to define the rules for the `responsive`
///
/// ```dart
/// WrapperConfig(
///   globalBreakpoints: ScreenBreakpoints(
///     mobile: 321,
///     tablet: 650,
///     desktop: 1100,
///   ),
///   themeRule: newRule,
/// )
/// ```
///
/// {@endtemplate}
class WrapperConfig {
  const WrapperConfig({
    this.globalBreakpoints = defaultMinimumBreakPoints,
    this.themeRule = ThemeRule.light,
    this.enableShortestSide = false,
  });

  final ScreenBreakpoints globalBreakpoints;
  final ThemeRule themeRule;
  final bool enableShortestSide;

  double getDeviceWidth(Size size) => getSizeByPlatform(
        size,
        shortestSide: enableShortestSide,
      );
}
