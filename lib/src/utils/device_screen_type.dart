import 'package:argo/src/platform_info/platform_info.dart';
import 'package:argo/src/utils/screen_breakpoints.dart';
import 'package:argo/src/utils/size_by_platform.dart';
import 'package:flutter/widgets.dart';

import 'condition_screen.dart';

enum DeviceScreenType { mobile, tablet, desktop }

extension DeviceScreenTypeX on DeviceScreenType {
  static DeviceScreenType getDeviceTypeFromSize(Size size) =>
      getDeviceType(size, defaultBreakPoints);

  static DeviceScreenType getDeviceType(Size size, ScreenBreakpoints breakpoint) {
    double deviceWidth = getSizeByPlatform(size);

    if (deviceWidth > breakpoint.desktop) {
      return DeviceScreenType.desktop;
    }

    if (deviceWidth > breakpoint.tablet) {
      return DeviceScreenType.tablet;
    }

    return DeviceScreenType.mobile;
  }

  double? getBreakpoint(ScreenBreakpoints sbp) => {
        DeviceScreenType.mobile: sbp.mobile,
        DeviceScreenType.tablet: sbp.tablet,
        DeviceScreenType.desktop: sbp.desktop,
      }[this];
}
