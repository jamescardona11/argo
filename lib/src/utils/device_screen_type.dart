import 'package:argo/src/platform_info/platform_info.dart';
import 'package:argo/src/utils/screen_breakpoints.dart';
import 'package:flutter/widgets.dart';

enum DeviceScreenType { mobile, tablet, desktop }

extension DeviceScreenTypeX on DeviceScreenType {
  static DeviceScreenType getDeviceType(Size size, ScreenBreakpoints breakpoint) {
    double deviceWidth = size.shortestSide;
    if (PlatformInfo.isWeb) {
      deviceWidth = size.width;
    }

    if (deviceWidth > breakpoint.desktop) {
      return DeviceScreenType.desktop;
    }

    if (deviceWidth > breakpoint.tablet) {
      return DeviceScreenType.tablet;
    }

    return DeviceScreenType.mobile;
  }

  static DeviceScreenType fromSize(Size size) {
    double deviceWidth = size.shortestSide;
    if (PlatformInfo.isWeb) {
      deviceWidth = size.width;
    }

    if (deviceWidth > defaultBreakPoints.desktop) {
      return DeviceScreenType.desktop;
    }

    if (deviceWidth > defaultBreakPoints.tablet) {
      return DeviceScreenType.tablet;
    }

    return DeviceScreenType.mobile;
  }
}
