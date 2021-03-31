import 'package:flutter/widgets.dart';

import '../extensions/list_extension.dart';
import '../models/condition.dart';
import '../models/condition_breakpoint.dart';
import '../models/device_screen.dart';
import '../models/screen_breakpoints.dart';
import '../models/wrapper_config.dart';
import '../widgets/responsive_wrapper.dart';
import 'get_current_breakpoints.dart';

/// Goal, Get a value for an list of conditions
/// [breakpoints] Currentbreakpoint for widget from(LocalBreakpoints, GlobalBreakpoints or DefaultBreakpoints)
/// [CurrentSize] The current size for view screen
/// [defaultValue] Default value in case you List of [conditions] don't return anything

T valueFromConditionByBreakpoints<T>({
  required BuildContext context,
  required List<ConditionBreakpoint<T>> condition,
  ScreenBreakpoints? localBreakpoints,
  required T defaultValue,
}) {
  condition.removeWhere((element) => element.isNull);

  final rw = ResponsiveWrapper.getWrapperConfig(context);
  final breakpoints = getCurrentBreakPoints(
    global: rw.globalBreakpoints,
    local: localBreakpoints,
  );

  final valueWhen = _setDefaultValuesToConditions<T>(
    breakpoints,
    condition,
  );

  valueWhen.sort((a, b) => a.breakpoint!.compareTo(b.breakpoint!));
  final activeCondition = _getActiveCondition<T>(
    context,
    rw,
    valueWhen,
    breakpoints,
  );

  return activeCondition?.value ?? defaultValue;
}

ConditionBreakpoint<T>? _getActiveCondition<T>(
  BuildContext context,
  WrapperConfig rw,
  List<ConditionBreakpoint<T>> conditions,
  ScreenBreakpoints breakpoints,
) {
  final size = MediaQuery.of(context).size;
  final deviceWith = rw.getDeviceWidth(size);

  final ConditionBreakpoint<T>? equalsCondition = conditions
      .where((element) => element.conditional == Conditional.EQUALS)
      .firstWhereOrNull((element) =>
          DeviceScreenX.fromBreakpoint(deviceWith, breakpoints) == element.screenType);

  if (equalsCondition != null) {
    return equalsCondition;
  }

  final ConditionBreakpoint<T>? smallerThanCondition = conditions
      .where((element) => element.conditional == Conditional.SMALLER_THAN)
      .firstWhereOrNull((element) => deviceWith < element.breakpoint!);

  if (smallerThanCondition != null) {
    return smallerThanCondition;
  }

  final ConditionBreakpoint<T>? largerThanCondition = conditions.reversed
      .where((element) => element.conditional == Conditional.LARGER_THAN)
      .firstWhereOrNull((element) => deviceWith >= element.breakpoint!);

  if (largerThanCondition != null) {
    return largerThanCondition;
  }

  return null;
}

List<ConditionBreakpoint<T>> _setDefaultValuesToConditions<T>(
  ScreenBreakpoints currentBreakpoints,
  List<ConditionBreakpoint<T>> conditions,
) =>
    conditions.map((cdt) {
      if (cdt.breakpoint == null) {
        return cdt.copyWith(
            breakpoint: cdt.screenType!.getScreenValue(currentBreakpoints));
      }
      return cdt;
    }).toList();
