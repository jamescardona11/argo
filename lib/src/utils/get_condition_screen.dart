import '../models/condition_screen.dart';
import '../models/device_screen.dart';
import '../models/screen_breakpoints.dart';
import 'package:flutter/widgets.dart';

T valueFromCondition<T>(
  Size currentSize,
  ConditionScreen conditionScreen,
  ScreenBreakpoints breakpoint,
  T defaultValue,
) {
  final deviceScreenType = DeviceScreenTypeX.fromBreakpoint(currentSize, breakpoint);

  switch (deviceScreenType) {
    case DeviceScreenType.mobile:
      return conditionScreen.mobile ?? defaultValue;
    case DeviceScreenType.tablet:
      return conditionScreen.tablet ?? defaultValue;
    case DeviceScreenType.desktop:
      return conditionScreen.desktop ?? defaultValue;
  }
}
