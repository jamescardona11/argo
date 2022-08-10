import 'package:flutter/widgets.dart';

import 'package:argo/src/widgets/responsive_wrapper.dart';
import 'package:argo/src/extensions/list_extension.dart';
import 'package:argo/src/models/models.dart';
import 'get_current_breakpoints.dart';

/// {@template get_conditions_breakpoints}
///
/// The goal is to get the actual value for a list of `conditions`.
///
///
/// `context` it is `BuildContext` of the app or the widget.
///
///
/// `localBreakpoints` are the local breakpoints for the widget.
///
///
/// `condition` The list of conditions to evaluate.
///
///
/// `defaultValue` Default value in case your list of `conditions` doesn't return anything.
///
/// The priority of this method is to calculate the value of the conditions,
/// the priority will be `EQUALS`, `SMALLER_THAN`, `LARGER_THAN`
///
///
/// For the [ConditionBreakpoint] where `breakpoint` was null and
/// the values were send like a [DeviceScreen] the `breakpoint` will be change between
/// `localBreakpoints`, `GlobalBreakpoints` or `DefaultBreakpoints`
/// using [getCurrentBreakPoints]
///
///{@endtemplate}

T? valueFromConditionByBreakpointsFunc<T>({
  required BuildContext context,
  required List<ConditionBreakpoint<T>> condition,
  ScreenBreakpoints? localBreakpoints,
  T? defaultValue,
}) {
  final nCondition = List<ConditionBreakpoint<T>>.from(condition);

  nCondition.removeWhere((element) => element.isNull);

  final rw = ResponsiveWrapper.getWrapperConfig(context);
  final breakpoints = getCurrentBreakPointsFunc(
    global: rw.globalBreakpoints,
    local: localBreakpoints,
  );

  final valueWhen = _setDefaultValuesToConditions<T>(
    breakpoints,
    nCondition,
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
          DeviceScreenX.fromBreakpoint(deviceWith, breakpoints) ==
          element.screenType);

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
            breakpoint:
                cdt.screenType!.getScreenValue(currentBreakpoints)!.value);
      }
      return cdt;
    }).toList();
