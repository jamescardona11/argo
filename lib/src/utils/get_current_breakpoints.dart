import 'package:flutter/widgets.dart';

import '../models/screen_breakpoints.dart';
import '../widgets/responsive_wrapper.dart';

/// Get the current breakpoint from LocalBreakpoints, GlobalBreakpoints or DefaultBreakpoints
ScreenBreakpoints getCurrentBreakPoints({
  required BuildContext context,
  ScreenBreakpoints? local,
}) {
  final rw = IWResponsiveWrapper.of(context);
  final ScreenBreakpoints? globalBreakpoints = rw?.globalBreakpoints;

  return defaultBreakPoints.copyWith(
    mobile: _getDoubleValue(local?.mobile, globalBreakpoints?.mobile),
    tablet: _getDoubleValue(local?.tablet, globalBreakpoints?.tablet),
    desktop: _getDoubleValue(local?.desktop, globalBreakpoints?.desktop),
  );
}

double? _getDoubleValue(double? local, double? globalBreakpoints) {
  return local ?? globalBreakpoints;
}
