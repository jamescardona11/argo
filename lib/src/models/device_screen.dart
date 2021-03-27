import 'package:flutter/widgets.dart';

import '../utils/size_by_platform.dart';
import 'screen_breakpoints.dart';
import 'screen_model.dart';

enum DeviceScreenType { mobile, tablet, desktop }

extension DeviceScreenTypeX on DeviceScreenType {
  bool isMobile() => this == DeviceScreenType.mobile;
  bool isTablet() => this == DeviceScreenType.tablet;
  bool isDesktop() => this == DeviceScreenType.desktop;

  T? getScreenValue<T>(ScreenModel<T> sbp) => {
        DeviceScreenType.mobile: sbp.mobile,
        DeviceScreenType.tablet: sbp.tablet,
        DeviceScreenType.desktop: sbp.desktop,
      }[this];

  static DeviceScreenType fromSize(Size size) => fromBreakpoint(size, defaultBreakPoints);

  static DeviceScreenType fromBreakpoint(Size size, ScreenBreakpoints breakpoint) {
    double deviceWidth = getSizeByPlatform(size);

    if (deviceWidth > breakpoint.desktop!) {
      return DeviceScreenType.desktop;
    }

    if (deviceWidth > breakpoint.tablet!) {
      return DeviceScreenType.tablet;
    }

    return DeviceScreenType.mobile;
  }
}
