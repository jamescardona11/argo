import 'package:flutter/widgets.dart';

import '../models/device_screen.dart';
import '../models/responsive_information.dart';
import '../models/screen_breakpoints.dart';
import '../widgets/responsive_wrapper.dart';
import 'get_current_breakpoints.dart';

/// {@template get_responsive_information}
///
/// Util to get the responsive information.
///
///
/// `context` it is `BuildContext` of the widget.
///
///
/// `localSize` is the value gets from constrains.
///
///
/// `localBreakpoints` are the local breakpoints for the widget.
///
/// {@endtemplate}
ResponsiveInformation getResponsiveInformation({
  required BuildContext context,
  Size? localSize,
  ScreenBreakpoints? localBreakpoints,
}) {
  final rw = ResponsiveWrapper.getWrapperConfig(context);
  final breakpoints = getCurrentBreakPoints(
    global: rw.globalBreakpoints,
    local: localBreakpoints,
  );

  final mp = MediaQuery.of(context);
  final deviceWith = rw.getDeviceWidth(mp.size);
  final deviceScreen = DeviceScreenX.fromBreakpoint(deviceWith, breakpoints);
  deviceScreen.isMobile();

  return ResponsiveInformation(
    deviceScreen: deviceScreen,
    screenSize: mp.size,
    localSize: localSize ?? mp.size,
    currentBreakpoints: breakpoints,
    orientation: mp.orientation,
  );
}
