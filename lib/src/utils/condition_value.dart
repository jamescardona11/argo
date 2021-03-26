import 'package:argo/src/platform_info/platform_info.dart';
import 'package:argo/src/utils/condition.dart';
import 'package:argo/src/utils/screen_breakpoints.dart';
import 'package:argo/src/utils/extension_list.dart';
import 'package:flutter/widgets.dart';

import 'device_screen_type.dart';

/// Goal: Get a value for an array of conditions
/// breakpoints: Currentbreakpoint for widget from(global, local and default)
T valueFromCondition<T>(
  Size currentSize,
  ScreenBreakpoints breakpoints,
  T defaultValue,
  List<Condition<T>> valueWhen,
) {
  valueWhen
      .removeWhere((element) => element.breakpoint == null && element.screenType == null);

  final conditions = valueWhen.map((cdt) {
    if (cdt.breakpoint == null) {
      return cdt.copyWith(breakpoint: _breakpointFromType(breakpoints, cdt.screenType!));
    }
    return cdt;
  }).toList();
  conditions.sort((a, b) => a.breakpoint!.compareTo(b.breakpoint!));

  final condition = getActiveCondition(valueWhen, currentSize);

  return condition?.value ?? defaultValue;
}

Condition? getActiveCondition(List<Condition> conditions, Size currentSize) {
  Condition? equalsCondition = conditions
      .where((element) => element.conditional == Conditional.EQUALS)
      .firstWhereOrNull(
          (element) => DeviceScreenTypeX.fromSize(currentSize) == element.screenType);

  if (equalsCondition != null) {
    return equalsCondition;
  }

  Condition? smallerThanCondition = conditions
      .where((element) => element.conditional == Conditional.SMALLER_THAN)
      .firstWhereOrNull((element) => _getInternalSize(currentSize) < element.breakpoint!);

  if (smallerThanCondition != null) {
    return smallerThanCondition;
  }

  Condition? largerThanCondition = conditions.reversed
      .where((element) => element.conditional == Conditional.LARGER_THAN)
      .firstWhereOrNull(
          (element) => _getInternalSize(currentSize) >= element.breakpoint!);

  if (largerThanCondition != null) {
    return largerThanCondition;
  }

  return null;
}

double? _breakpointFromType(ScreenBreakpoints sbp, DeviceScreenType type) => {
      DeviceScreenType.mobile: sbp.mobile,
      DeviceScreenType.tablet: sbp.tablet,
      DeviceScreenType.desktop: sbp.desktop,
    }[type];

double _getInternalSize(Size size) {
  double deviceWidth = size.shortestSide;
  if (PlatformInfo.isWeb) {
    deviceWidth = size.width;
  }

  return deviceWidth;
}
