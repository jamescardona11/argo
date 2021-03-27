import 'package:flutter/widgets.dart';

import '../models/condition.dart';
import '../models/condition_breakpoint.dart';
import '../models/condition_screen.dart';
import '../models/screen_breakpoints.dart';
import '../utils/get_condition_breakpoint.dart';
import '../utils/get_condition_screen.dart';
import '../utils/get_current_breakpoints.dart';

class ResponsiveVisibility extends StatelessWidget {
  final Widget child;
  final List<ConditionBreakpoint<bool>> hiddenWhen;
  final List<ConditionBreakpoint<bool>> visibleWhen;
  final ConditionScreen<bool> conditionScreen;
  final bool maintainAnimation;
  final bool maintainInteractivity;
  final bool maintainSemantics;
  final bool maintainSize;
  final bool maintainState;
  final Widget replacement;
  final bool visible;
  final ScreenBreakpoints? breakpoints;
  final ConditionType? type;

  ResponsiveVisibility.conditions({
    Key? key,
    required this.child,
    this.visible = true,
    this.visibleWhen = const [],
    this.hiddenWhen = const [],
    this.replacement = const SizedBox.shrink(),
    this.maintainState = false,
    this.maintainAnimation = false,
    this.maintainSize = false,
    this.maintainSemantics = false,
    this.maintainInteractivity = false,
    this.breakpoints,
  })  : type = ConditionType.conditions,
        conditionScreen = _defaultConditionScreenVisibility;

  ResponsiveVisibility.screen({
    Key? key,
    required this.child,
    this.visible = true,
    this.conditionScreen = _defaultConditionScreenVisibility,
    this.replacement = const SizedBox.shrink(),
    this.maintainState = false,
    this.maintainAnimation = false,
    this.maintainSize = false,
    this.maintainSemantics = false,
    this.maintainInteractivity = false,
    this.breakpoints,
  })  : type = ConditionType.screen,
        visibleWhen = const [],
        hiddenWhen = const [];

  @override
  Widget build(BuildContext context) {
    // Initialize mutable value holders.
    bool visibleValue = getVisibilityValue(context);

    return Visibility(
      child: child,
      replacement: replacement,
      visible: visibleValue,
      maintainState: maintainState,
      maintainAnimation: maintainAnimation,
      maintainSize: maintainSize,
      maintainSemantics: maintainSemantics,
      maintainInteractivity: maintainInteractivity,
    );
  }

  bool getVisibilityValue(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<ConditionBreakpoint<bool>> conditions = [];
    bool visibleValue = visible;

    // Combine Conditions.
    conditions.addAll(visibleWhen.map((e) => e.copyWith(value: true)));
    conditions.addAll(hiddenWhen.map((e) => e.copyWith(value: false)));
    final bp = getCurrentBreakPoints(context: context, local: breakpoints);

    if (type! == ConditionType.conditions) {
      visibleValue = valueFromListCondition<bool>(
        currentSize: size,
        conditions: conditions,
        breakpoints: bp,
        defaultValue: visibleValue,
      );
    } else {
      visibleValue = valueFromCondition<bool>(
        currentSize: size,
        conditionScreen: conditionScreen,
        breakpoints: bp,
        defaultValue: visibleValue,
      );
    }

    return visibleValue;
  }
}

const _defaultConditionScreenVisibility = ConditionScreen<bool>(
  mobile: true,
  tablet: false,
  desktop: false,
);
