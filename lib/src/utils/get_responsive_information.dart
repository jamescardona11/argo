import 'package:argo/src/models/models.dart';
import 'package:argo/src/widgets/responsive_wrapper.dart';
import 'package:flutter/widgets.dart';

import 'utils.dart';

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
  final globalBreakpoints = ResponsiveWrapper.getGlobalBreakpoints(context);
  final breakpoints = getCurrentBreakPointsFunc(
    global: globalBreakpoints,
    local: localBreakpoints,
  );

  final mp = MediaQuery.of(context);
  final deviceWith = getSizeByPlatform(mp.size);

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
