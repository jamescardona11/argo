import 'package:flutter/widgets.dart';

import '../models/condition_screen.dart';
import '../models/device_screen.dart';
import '../models/screen_breakpoints.dart';
import '../widgets/responsive_wrapper.dart';
import 'get_current_breakpoints.dart';

/// {@template get_conditions_screen}
///
/// The goal is to obtain the actual value for the `conditions` by `screen`
///
/// `context` it is `BuildContext` of the app or the widget
/// `localBreakpoints` are the local breakpoints for the widget
/// `condition` the list of conditions to evaluate
/// `defaultValue` Default value in case your list of `conditions` doesn't return anything
///
/// First point is to find wich are the actual `breakpoints` between
/// `localBreakpoints`, `GlobalBreakpoints` or `DefaultBreakpoints`
/// using [getCurrentBreakPoints]
///
/// Then the method will compare the actual `Size` with the breakpoints to get the`DeviceScreen`
/// Finally the method gets the value for `condition`
///
/// {@endtemplate }

T valueFromConditionByScreen<T>({
  required BuildContext context,
  required ConditionScreen<T> condition,
  ScreenBreakpoints? localBreakpoints,
  required T defaultValue,
}) {
  final rw = ResponsiveWrapper.getWrapperConfig(context);
  final breakpoints = getCurrentBreakPoints(
    global: rw.globalBreakpoints,
    local: localBreakpoints,
  );

  final size = MediaQuery.of(context).size;
  final deviceWith = rw.getDeviceWidth(size);
  final deviceScreenType = DeviceScreenX.fromBreakpoint(deviceWith, breakpoints);

  return deviceScreenType.getScreenValue(condition) ?? defaultValue;
}
