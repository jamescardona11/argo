import 'package:argo/src/extensions/responsive_extension.dart';
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

  final size = context.sizePx;
  final deviceWith = getSizeByPlatform(size);

  final deviceScreen = DeviceScreenX.fromBreakpoint(deviceWith, breakpoints);
  deviceScreen.isMobile();

  return ResponsiveInformation(
    deviceScreen: deviceScreen,
    screenSize: size,
    localSize: localSize ?? size,
    currentBreakpoints: breakpoints,
    orientation: context.orientation,
  );
}
