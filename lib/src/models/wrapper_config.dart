import 'package:flutter/widgets.dart';

import '../theme/theme_rule.dart';
import '../utils/size_by_platform.dart';
import 'screen_breakpoints.dart';

class WrapperConfig {
  final ScreenBreakpoints globalBreakpoints;
  final ThemeRule themeRule;
  final bool enableShortestSide;

  const WrapperConfig({
    this.globalBreakpoints = defaultBreakPoints,
    this.themeRule = ThemeRule.light,
    this.enableShortestSide = false,
  });

  double getDeviceWidth(Size size) =>
      getSizeByPlatform(size, shortestSide: enableShortestSide);
}
