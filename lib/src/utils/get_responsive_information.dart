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
class GetResponsiveInformation {
  ResponsiveInformation value({
    required BuildContext context,
    required Size screenSize,
    required Size localSize,
    ScreenBreakpoints? localBreakpoints,
  }) {
    final breakpoints = ResponsiveWrapper.breakpoints(context, local: localBreakpoints);

    final deviceWith = getSizeByPlatform(screenSize);

    final deviceScreen = DeviceScreenX.fromBreakpoint(deviceWith, breakpoints);
    deviceScreen.isMobile();

    return ResponsiveInformation(
      deviceScreen: deviceScreen,
      screenSize: screenSize,
      localSize: localSize,
      currentBreakpoints: breakpoints,
      orientation: context.orientation,
    );
  }
}
