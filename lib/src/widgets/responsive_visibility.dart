import 'package:flutter/widgets.dart';

import '../models/condition.dart';
import '../models/condition_breakpoint.dart';
import '../models/condition_screen.dart';
import '../models/screen_breakpoints.dart';
import '../utils/get_condition_breakpoint.dart';
import '../utils/get_condition_screen.dart';
import '../utils/get_current_breakpoints.dart';

/// Widget to handle the visbility with conditions [ConditionBreakpoint or ConditionScreen]
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

  const ResponsiveVisibility.conditions({
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
        conditionScreen = _defaultConditionScreenVisibility,
        super(key: key);

  const ResponsiveVisibility.screen({
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
        hiddenWhen = const [],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize mutable value holders.
    final bool visibleValue = getVisibilityValue(context);

    return Visibility(
      replacement: replacement,
      visible: visibleValue,
      maintainState: maintainState,
      maintainAnimation: maintainAnimation,
      maintainSize: maintainSize,
      maintainSemantics: maintainSemantics,
      maintainInteractivity: maintainInteractivity,
      child: child,
    );
  }

  bool getVisibilityValue(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<ConditionBreakpoint<bool>> conditions = [];
    bool visibleValue = visible;

    // Combine Conditions.
    conditions.addAll(visibleWhen.map((e) => e.copyWith(value: true)));
    conditions.addAll(hiddenWhen.map((e) => e.copyWith(value: false)));
    final bp = getCurrentBreakPoints(context: context, local: breakpoints);

    if (type! == ConditionType.conditions) {
      visibleValue = valueFromConditionByBreakpoints<bool>(
        currentSize: size,
        condition: conditions,
        breakpoints: bp,
        defaultValue: visibleValue,
      );
    } else {
      visibleValue = valueFromConditionByScreen<bool>(
        currentSize: size,
        condition: conditionScreen,
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
