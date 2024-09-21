import 'package:argo/argo.dart';
import 'package:argo/src/models/models.dart';
import 'package:flutter/widgets.dart';

import 'utils.dart';

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

class GetConditionBreakpoint<T> {
  T? value({
    required BuildContext context,
    required Size size,
    required List<ConditionBreakpoint<T>> conditions,
    ScreenBreakpoints? localBreakpoints,
  }) {
    final breakpoints = ResponsiveWrapper.breakpoints(context, local: localBreakpoints);
    final valueWhen = conditions
        .where((element) => !element.hasNull)
        .map((cdt) {
          if (cdt.breakpoint == null) {
            return cdt.copyWith(breakpoint: cdt.screenType!.getScreenValue(breakpoints)?.value);
          }
          return cdt;
        })
        .where((element) => !element.hasNull)
        .toList();

    valueWhen.sort((a, b) => a.breakpoint!.compareTo(b.breakpoint!));

    final activeCondition = _getActiveCondition(
      size,
      valueWhen,
      breakpoints,
    );

    return activeCondition?.value;
  }

  ConditionBreakpoint<T>? _getActiveCondition<T>(
    Size size,
    List<ConditionBreakpoint<T>> conditions,
    ScreenBreakpoints breakpoints,
  ) {
    final deviceWith = getSizeByPlatform(size);

    final ConditionBreakpoint<T>? equalsCondition = conditions
        .where((element) => element.conditional == Conditional.EQUALS)
        .where((element) => DeviceScreenX.fromBreakpoint(deviceWith, breakpoints) == element.screenType)
        .firstOrNull;

    if (equalsCondition != null) {
      return equalsCondition;
    }

    final ConditionBreakpoint<T>? smallerThanCondition = conditions
        .where((element) => element.conditional == Conditional.SMALLER_THAN)
        .where((element) => deviceWith < element.breakpoint!)
        .firstOrNull;

    if (smallerThanCondition != null) {
      return smallerThanCondition;
    }

    final ConditionBreakpoint<T>? largerThanCondition = conditions.reversed
        .where((element) => element.conditional == Conditional.LARGER_THAN)
        .where((element) => deviceWith >= element.breakpoint!)
        .firstOrNull;

    if (largerThanCondition != null) {
      return largerThanCondition;
    }

    return null;
  }
}
