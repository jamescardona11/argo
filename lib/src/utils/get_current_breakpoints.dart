import 'package:flutter/widgets.dart';

import '../models/screen_breakpoints.dart';
import '../widgets/responsive_wrapper.dart';

/// Get the current breakpoint from LocalBreakpoints, GlobalBreakpoints or DefaultBreakpoints
ScreenBreakpoints getCurrentBreakPoints({
  required ScreenBreakpoints global,
  ScreenBreakpoints? local,
}) {
  return defaultBreakPoints.copyWith(
    mobile: _getDoubleValue(local?.mobile, global.mobile),
    tablet: _getDoubleValue(local?.tablet, global.tablet),
    desktop: _getDoubleValue(local?.desktop, global.desktop),
  );
}

double? _getDoubleValue(double? local, double? globalBreakpoints) {
  return local ?? globalBreakpoints;
}
