import 'package:argo/src/utils/get_condition_breakpoint.dart';
import 'package:argo/src/utils/get_condition_screen.dart';
import 'package:argo/src/utils/get_current_breakpoints.dart';

import '../models/condition_breakpoint.dart';
import '../models/condition_screen.dart';
import '../models/screen_breakpoints.dart';
import 'package:flutter/widgets.dart';

class ResponsiveVisibility extends StatelessWidget {
  final ScreenBreakpoints? breakpoints;
  final Widget child;
  final List<ConditionBreakpoint> hiddenWhen;
  final List<ConditionBreakpoint> visibleWhen;
  final ConditionScreen conditionScreen;
  final bool maintainAnimation;
  final bool maintainInteractivity;
  final bool maintainSemantics;
  final bool maintainSize;
  final bool maintainState;
  final Widget replacement;
  final bool visible;
  final _ResponsiveVisibilityType? type;

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
  })  : type = _ResponsiveVisibilityType.conditions,
        conditionScreen = _defaultConditionScreen;

  ResponsiveVisibility.screen({
    Key? key,
    required this.child,
    this.visible = true,
    this.conditionScreen = _defaultConditionScreen,
    this.replacement = const SizedBox.shrink(),
    this.maintainState = false,
    this.maintainAnimation = false,
    this.maintainSize = false,
    this.maintainSemantics = false,
    this.maintainInteractivity = false,
    this.breakpoints,
  })  : type = _ResponsiveVisibilityType.screen,
        visibleWhen = const [],
        hiddenWhen = const [];

  @override
  Widget build(BuildContext context) {
    // Initialize mutable value holders.
    final size = MediaQuery.of(context).size;
    List<ConditionBreakpoint> conditions = [];
    bool visibleValue = visible;

    // Combine Conditions.
    conditions.addAll(visibleWhen.map((e) => e.copyWith(value: true)));
    conditions.addAll(hiddenWhen.map((e) => e.copyWith(value: false)));
    final bp = getCurrentBreakPoints(context: context, local: breakpoints);

    if (type! == _ResponsiveVisibilityType.conditions) {
      visibleValue = valueFromListCondition<bool>(size, bp, visibleValue, conditions);
    } else {
      visibleValue = valueFromCondition<bool>(size, conditionScreen, bp, true);
    }

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
}

enum _ResponsiveVisibilityType { screen, conditions }
const _defaultConditionScreen = ConditionScreen<bool>(
  mobile: true,
  tablet: false,
  desktop: false,
);
