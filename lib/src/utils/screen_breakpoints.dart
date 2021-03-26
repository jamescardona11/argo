import 'package:argo/src/responsive/responsive_wrapper.dart';
import 'package:flutter/widgets.dart';

// Minimum values breakpoints for type of device
const defaultBreakPoints = const ScreenBreakpoints(
  mobile: 320,
  tablet: 700,
  desktop: 1200,
);

class ScreenBreakpoints {
  final double mobile;
  final double tablet;
  final double desktop;

  const ScreenBreakpoints({
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  ScreenBreakpoints copyWith({
    double? mobile,
    double? tablet,
    double? desktop,
  }) =>
      ScreenBreakpoints(
        mobile: mobile ?? defaultBreakPoints.mobile,
        tablet: tablet ?? defaultBreakPoints.tablet,
        desktop: desktop ?? defaultBreakPoints.desktop,
      );

  @override
  String toString() {
    return "Desktop: $desktop, Tablet: $tablet, Mobile: $mobile";
  }
}

ScreenBreakpoints getBreakPoints(BuildContext context, ScreenBreakpoints? local) {
  final rw = ResponsiveWrapper.of(context);
  ScreenBreakpoints? globalBreakpoints = rw?.globalBreakpoints;

  return defaultBreakPoints.copyWith(
    mobile: local != null ? local.mobile : globalBreakpoints?.mobile,
    tablet: local != null ? local.tablet : globalBreakpoints?.tablet,
    desktop: local != null ? local.desktop : globalBreakpoints?.tablet,
  );
}
