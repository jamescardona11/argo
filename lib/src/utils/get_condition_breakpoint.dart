import 'package:flutter/widgets.dart';

import '../extensions/list_extension.dart';
import '../models/condition.dart';
import '../models/condition_breakpoint.dart';
import '../models/device_screen.dart';
import '../models/screen_breakpoints.dart';
import 'get_current_breakpoints.dart';
import 'size_by_platform.dart';

/// Goal, Get a value for an list of conditions
/// [breakpoints] Currentbreakpoint for widget from(LocalBreakpoints, GlobalBreakpoints or DefaultBreakpoints)
/// [CurrentSize] The current size for view screen
/// [defaultValue] Default value in case you List of [conditions] don't return anything
T valueFromConditionByBreakpoints<T>({
  required Size currentSize,
  required List<ConditionBreakpoint<T>> condition,
  required ScreenBreakpoints breakpoints,
  required T defaultValue,
}) {
  condition.removeWhere((element) => element.isNull);

  final valueWhen = _setDefaultValuesToConditions<T>(breakpoints, condition);
  valueWhen.sort((a, b) => a.breakpoint!.compareTo(b.breakpoint!));
  final activeCondition = _getActiveCondition<T>(valueWhen, currentSize, breakpoints);

  return activeCondition?.value ?? defaultValue;
}

List<ConditionBreakpoint<T>> _setDefaultValuesToConditions<T>(
        ScreenBreakpoints breakpoints, List<ConditionBreakpoint<T>> conditions) =>
    conditions.map((cdt) {
      if (cdt.breakpoint == null) {
        return cdt.copyWith(breakpoint: cdt.screenType!.getScreenValue(breakpoints));
      }
      return cdt;
    }).toList();

ConditionBreakpoint<T>? _getActiveCondition<T>(List<ConditionBreakpoint<T>> conditions,
    Size currentSize, ScreenBreakpoints breakpoints) {
  final ConditionBreakpoint<T>? equalsCondition = conditions
      .where((element) => element.conditional == Conditional.EQUALS)
      .firstWhereOrNull((element) =>
          DeviceScreenTypeX.fromBreakpoint(currentSize, breakpoints) ==
          element.screenType);

  if (equalsCondition != null) {
    return equalsCondition;
  }

  final ConditionBreakpoint<T>? smallerThanCondition = conditions
      .where((element) => element.conditional == Conditional.SMALLER_THAN)
      .firstWhereOrNull(
          (element) => getSizeByPlatform(currentSize) < element.breakpoint!);

  if (smallerThanCondition != null) {
    return smallerThanCondition;
  }

  final ConditionBreakpoint<T>? largerThanCondition = conditions.reversed
      .where((element) => element.conditional == Conditional.LARGER_THAN)
      .firstWhereOrNull(
          (element) => getSizeByPlatform(currentSize) >= element.breakpoint!);

  if (largerThanCondition != null) {
    return largerThanCondition;
  }

  return null;
}

T valueFromConditionByBreakpointsCtx<T>({
  required BuildContext context,
  required List<ConditionBreakpoint<T>> condition,
  required T defaultValue,
}) {
  final breakpoints = getCurrentBreakPoints(context: context);
  return valueFromConditionByBreakpoints(
    currentSize: MediaQuery.of(context).size,
    condition: condition,
    breakpoints: breakpoints,
    defaultValue: defaultValue,
  );
}
