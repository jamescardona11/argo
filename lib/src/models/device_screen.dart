import 'screen_breakpoints.dart';
import 'screen_model.dart';

enum DeviceScreen { mobile, tablet, desktop }

extension DeviceScreenX on DeviceScreen {
  bool isMobile() => this == DeviceScreen.mobile;
  bool isTablet() => this == DeviceScreen.tablet;
  bool isDesktop() => this == DeviceScreen.desktop;

  T? getScreenValue<T>(ScreenModel<T> sbp) => {
        DeviceScreen.mobile: sbp.mobile,
        DeviceScreen.tablet: sbp.tablet,
        DeviceScreen.desktop: sbp.desktop,
      }[this];

  static DeviceScreen fromBreakpoint(
    double deviceWidth,
    ScreenBreakpoints breakpoints,
  ) {
    if (breakpoints.isFloor) {
      if (deviceWidth >= breakpoints.desktop!) {
        return DeviceScreen.desktop;
      }

      if (deviceWidth > breakpoints.tablet!) {
        return DeviceScreen.tablet;
      }

      return DeviceScreen.mobile;
    } else {
      if (deviceWidth <= breakpoints.mobile!) {
        return DeviceScreen.mobile;
      }

      if (deviceWidth <= breakpoints.tablet!) {
        return DeviceScreen.tablet;
      }

      return DeviceScreen.desktop;
    }
  }
}
