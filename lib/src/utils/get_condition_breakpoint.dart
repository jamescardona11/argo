import 'package:flutter/widgets.dart';

import '../extensions/list_extension.dart';
import '../models/condition.dart';
import '../models/condition_breakpoint.dart';
import '../models/device_screen.dart';
import '../models/screen_breakpoints.dart';
import 'size_by_platform.dart';

/// Goal: Get a value for an array of conditions
/// breakpoints: Currentbreakpoint for widget from(global, local and default)
T valueFromListCondition<T>(
  Size currentSize,
  ScreenBreakpoints breakpoints,
  T defaultValue,
  List<ConditionBreakpoint> valueWhen,
) {
  valueWhen.removeWhere((element) => element.isNull);

  final conditions = _setDefaultValuesToConditions(breakpoints, valueWhen);
  conditions.sort((a, b) => a.breakpoint!.compareTo(b.breakpoint!));
  final activeCondition = getActiveCondition(valueWhen, currentSize);

  return activeCondition?.value ?? defaultValue;
}

List<ConditionBreakpoint> _setDefaultValuesToConditions(
        ScreenBreakpoints breakpoints, List<ConditionBreakpoint> conditions) =>
    conditions.map((cdt) {
      if (cdt.breakpoint == null) {
        return cdt.copyWith(breakpoint: cdt.screenType!.getBreakpoint(breakpoints));
      }
      return cdt;
    }).toList();

ConditionBreakpoint? getActiveCondition(
    List<ConditionBreakpoint> conditions, Size currentSize) {
  ConditionBreakpoint? equalsCondition = conditions
      .where((element) => element.conditional == Conditional.EQUALS)
      .firstWhereOrNull(
          (element) => DeviceScreenTypeX.fromSize(currentSize) == element.screenType);

  if (equalsCondition != null) {
    return equalsCondition;
  }

  ConditionBreakpoint? smallerThanCondition = conditions
      .where((element) => element.conditional == Conditional.SMALLER_THAN)
      .firstWhereOrNull(
          (element) => getSizeByPlatform(currentSize) < element.breakpoint!);

  if (smallerThanCondition != null) {
    return smallerThanCondition;
  }

  ConditionBreakpoint? largerThanCondition = conditions.reversed
      .where((element) => element.conditional == Conditional.LARGER_THAN)
      .firstWhereOrNull(
          (element) => getSizeByPlatform(currentSize) >= element.breakpoint!);

  if (largerThanCondition != null) {
    return largerThanCondition;
  }

  return null;
}
