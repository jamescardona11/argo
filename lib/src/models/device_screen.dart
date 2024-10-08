import 'package:argo/src/models/models.dart';

/// Enum that stores an interpretation of `ScreenType` for apps
enum DeviceScreen {
  mobile,
  tablet,
  desktop;

  bool isMobile() => this == DeviceScreen.mobile;
  bool isTablet() => this == DeviceScreen.tablet;
  bool isDesktop() => this == DeviceScreen.desktop;
}

/// Extension to compare and get type of [DeviceScreen] easily,
/// additionally we can get the value depending of the current `screen` with `getScreenValue` method
extension DeviceScreenX on DeviceScreen {
  T? getScreenValue<T>(ScreenModel<T> sbp) => {
        DeviceScreen.mobile: sbp.mobile,
        DeviceScreen.tablet: sbp.tablet,
        DeviceScreen.desktop: sbp.desktop,
      }[this];

  static DeviceScreen fromBreakpoint(
    double deviceWidth,
    ScreenBreakpoints breakpoints,
  ) {
    if (breakpoints.isMinSBValue) {
      if (deviceWidth >= breakpoints.desktop!.value) {
        return DeviceScreen.desktop;
      }

      if (deviceWidth > breakpoints.tablet!.value) {
        return DeviceScreen.tablet;
      }

      return DeviceScreen.mobile;
    } else {
      if (deviceWidth <= breakpoints.mobile!.value) {
        return DeviceScreen.mobile;
      }

      if (deviceWidth <= breakpoints.tablet!.value) {
        return DeviceScreen.tablet;
      }

      return DeviceScreen.desktop;
    }
  }
}
