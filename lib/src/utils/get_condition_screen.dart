import 'package:flutter/widgets.dart';

import '../models/condition_screen.dart';
import '../models/device_screen.dart';
import '../models/screen_breakpoints.dart';
import 'get_current_breakpoints.dart';

/// Goal, Get a value for conditions screen
/// [breakpoints] Currentbreakpoint for widget from(LocalBreakpoints, GlobalBreakpoints or DefaultBreakpoints)
/// [CurrentSize] The current size for view screen
/// [defaultValue] Default value in case you List of [conditions] don't return anything
T valueFromConditionByScreen<T>({
  required Size currentSize,
  required ConditionScreen<T> condition,
  required ScreenBreakpoints breakpoints,
  required T defaultValue,
}) {
  final deviceScreenType = DeviceScreenTypeX.fromBreakpoint(currentSize, breakpoints);
  return deviceScreenType.getScreenValue(condition) ?? defaultValue;
}

T valueFromConditionCtx<T>({
  required BuildContext context,
  required ConditionScreen<T> conditionScreen,
  required T defaultValue,
}) {
  final breakpoints = getCurrentBreakPoints(context: context);
  return valueFromConditionByScreen(
    currentSize: MediaQuery.of(context).size,
    condition: conditionScreen,
    breakpoints: breakpoints,
    defaultValue: defaultValue,
  );
}
