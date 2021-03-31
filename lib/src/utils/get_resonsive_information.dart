import 'package:flutter/widgets.dart';

import '../models/device_screen.dart';
import '../models/responsive_information.dart';
import '../models/screen_breakpoints.dart';
import '../widgets/responsive_wrapper.dart';
import 'get_current_breakpoints.dart';

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
  final deviceScreenType = DeviceScreenX.fromBreakpoint(deviceWith, breakpoints);

  return ResponsiveInformation(
    deviceScreenType: deviceScreenType,
    screenSize: mp.size,
    localSize: localSize ?? mp.size,
    currentBreakpoints: breakpoints,
    orientation: mp.orientation,
  );
}
