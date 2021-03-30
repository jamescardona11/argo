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
    mobile: local != null ? local.mobile : globalBreakpoints?.mobile,
    tablet: local != null ? local.tablet : globalBreakpoints?.tablet,
    desktop: local != null ? local.desktop : globalBreakpoints?.tablet,
  );
}
