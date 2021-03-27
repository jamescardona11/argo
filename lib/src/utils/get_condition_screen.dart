import 'package:flutter/widgets.dart';

import '../models/condition_screen.dart';
import '../models/device_screen.dart';
import '../models/screen_breakpoints.dart';
import 'get_current_breakpoints.dart';

T valueFromCondition<T>({
  required Size currentSize,
  required ConditionScreen<T> conditionScreen,
  required ScreenBreakpoints breakpoints,
  required T defaultValue,
}) {
  final deviceScreenType = DeviceScreenTypeX.fromBreakpoint(currentSize, breakpoints);
  return deviceScreenType.getScreenValue(conditionScreen) ?? defaultValue;
}

T valueFromConditionCtx<T>({
  required BuildContext context,
  required ConditionScreen<T> conditionScreen,
  required T defaultValue,
}) {
  final breakpoints = getCurrentBreakPoints(context: context);
  return valueFromCondition(
    currentSize: MediaQuery.of(context).size,
    conditionScreen: conditionScreen,
    breakpoints: breakpoints,
    defaultValue: defaultValue,
  );
}
