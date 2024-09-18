import 'package:argo/src/models/models.dart';
import 'package:argo/src/widgets/responsive_wrapper.dart';
import 'package:flutter/widgets.dart';

import 'utils.dart';

/// {@template get_conditions_screen}
///
/// The goal is to obtain the actual value for the `conditions` by `screen`.
///
///
/// `context` it is `BuildContext` of the app or the widget.
///
///
/// `localBreakpoints` are the local breakpoints for the widget.
///
///
/// `condition` the list of conditions to evaluate.
///
///
/// `defaultValue` Default value in case your list of `conditions` doesn't return anything.
///
///
///
/// First point is to find which are the actual `breakpoints` between
/// `localBreakpoints`, `GlobalBreakpoints` or `DefaultBreakpoints`
/// using [getCurrentBreakPoints]
///
/// Then the method will compare the actual `Size` with the breakpoints to get the`DeviceScreen`
/// Finally the method gets the value for `condition`
///
/// {@endtemplate }

T? valueFromConditionByScreenFunc<T>({
  required BuildContext context,
  required ConditionScreen<T> condition,
  ScreenBreakpoints? localBreakpoints,
  required T defaultValue,
}) {
  final globalBreakpoints = ResponsiveWrapper.getGlobalBreakpoints(context);

  final breakpoints = getCurrentBreakPointsFunc(
    global: globalBreakpoints,
    local: localBreakpoints,
  );

  final size = MediaQuery.of(context).size;
  final deviceWith = getSizeByPlatform(size);
  final deviceScreenType = DeviceScreenX.fromBreakpoint(deviceWith, breakpoints);

  final deviceScreen = deviceScreenType.getScreenValue(condition);

  return deviceScreen;
}
