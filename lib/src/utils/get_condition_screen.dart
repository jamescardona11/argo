import 'package:flutter/widgets.dart';

import '../models/condition_screen.dart';
import '../models/device_screen.dart';
import '../models/screen_breakpoints.dart';
import '../widgets/responsive_wrapper.dart';
import 'get_current_breakpoints.dart';

/// Goal, Get a value for conditions screen
/// [localBreakpoints] Currentbreakpoint for widget from(LocalBreakpoints, GlobalBreakpoints or DefaultBreakpoints)
/// [CurrentSize] The current size for view screen
/// [defaultValue] Default value in case you List of [conditions] don't return anything

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
