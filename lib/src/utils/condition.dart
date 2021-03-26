import 'package:argo/src/utils/size_by_platform.dart';

import 'device_screen_type.dart';
import 'package:flutter/widgets.dart';

import '../platform_info/platform_info.dart';
import 'extension_list.dart';
import 'screen_breakpoints.dart';

class Condition<T> {
  final DeviceScreenType? screenType;
  final Conditional? conditional;
  final T? value;
  final double? breakpoint;

  const Condition._({
    this.screenType,
    this.conditional,
    this.value,
    this.breakpoint,
  })  : assert(breakpoint != null || screenType != null),
        assert((conditional == Conditional.EQUALS) ? screenType != null : true);

  const Condition.equals({required DeviceScreenType type, T? value})
      : this.screenType = type,
        this.value = value,
        this.breakpoint = null,
        this.conditional = Conditional.EQUALS;

  const Condition.largerThan({DeviceScreenType? type, double? breakpoint, T? value})
      : this.screenType = type,
        this.value = value,
        this.breakpoint = breakpoint,
        this.conditional = Conditional.LARGER_THAN;

  const Condition.smallerThan({DeviceScreenType? type, double? breakpoint, T? value})
      : this.screenType = type,
        this.value = value,
        this.breakpoint = breakpoint,
        this.conditional = Conditional.SMALLER_THAN;

  bool get isNull => breakpoint == null && screenType == null;

  Condition copyWith(
          {DeviceScreenType? type,
          Conditional? condition,
          T? value,
          double? breakpoint}) =>
      Condition._(
        screenType: type ?? this.screenType,
        conditional: condition ?? this.conditional,
        value: value ?? this.value,
        breakpoint: breakpoint ?? this.breakpoint,
      );

  @override
  String toString() =>
      'Condition(' +
      'breakpoint: ' +
      breakpoint.toString() +
      ', type: ' +
      screenType.toString() +
      ', condition: ' +
      conditional.toString() +
      ', value: ' +
      value.toString() +
      ')';
}

enum Conditional {
  EQUALS,
  SMALLER_THAN,
  LARGER_THAN,
}

/// Goal: Get a value for an array of conditions
/// breakpoints: Currentbreakpoint for widget from(global, local and default)
T valueFromListCondition<T>(
  Size currentSize,
  ScreenBreakpoints breakpoints,
  T defaultValue,
  List<Condition> valueWhen,
) {
  valueWhen.removeWhere((element) => element.isNull);

  final conditions = _setDefaultValuesToConditions(breakpoints, valueWhen);
  conditions.sort((a, b) => a.breakpoint!.compareTo(b.breakpoint!));
  final activeCondition = getActiveCondition(valueWhen, currentSize);

  return activeCondition?.value ?? defaultValue;
}

List<Condition> _setDefaultValuesToConditions(
        ScreenBreakpoints breakpoints, List<Condition> conditions) =>
    conditions.map((cdt) {
      if (cdt.breakpoint == null) {
        return cdt.copyWith(breakpoint: cdt.screenType!.getBreakpoint(breakpoints));
      }
      return cdt;
    }).toList();

Condition? getActiveCondition(List<Condition> conditions, Size currentSize) {
  Condition? equalsCondition = conditions
      .where((element) => element.conditional == Conditional.EQUALS)
      .firstWhereOrNull((element) =>
          DeviceScreenTypeX.getDeviceTypeFromSize(currentSize) == element.screenType);

  if (equalsCondition != null) {
    return equalsCondition;
  }

  Condition? smallerThanCondition = conditions
      .where((element) => element.conditional == Conditional.SMALLER_THAN)
      .firstWhereOrNull(
          (element) => getSizeByPlatform(currentSize) < element.breakpoint!);

  if (smallerThanCondition != null) {
    return smallerThanCondition;
  }

  Condition? largerThanCondition = conditions.reversed
      .where((element) => element.conditional == Conditional.LARGER_THAN)
      .firstWhereOrNull(
          (element) => getSizeByPlatform(currentSize) >= element.breakpoint!);

  if (largerThanCondition != null) {
    return largerThanCondition;
  }

  return null;
}
