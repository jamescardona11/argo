import 'package:flutter/widgets.dart';

import '../models/condition.dart';
import '../models/condition_breakpoint.dart';
import '../models/condition_screen.dart';
import '../models/screen_breakpoints.dart';
import '../utils/get_condition_breakpoint.dart';
import '../utils/get_condition_screen.dart';

/// Widget to handle the visbility with conditions [ConditionBreakpoint or ConditionScreen]
class ResponsiveVisibility extends StatelessWidget {
  final Widget child;
  final List<ConditionBreakpoint<bool>> hiddenWhen;
  final List<ConditionBreakpoint<bool>> visibleWhen;
  final ConditionScreen<bool> conditionScreen;
  final bool visible;
  final ScreenBreakpoints? localBreakpoints;
  final ConditionType? type;

  const ResponsiveVisibility.conditions({
    Key? key,
    required this.child,
    this.visible = true,
    this.visibleWhen = const [],
    this.hiddenWhen = const [],
    this.localBreakpoints,
  })  : type = ConditionType.conditions,
        conditionScreen = _defaultConditionScreenVisibility,
        super(key: key);

  const ResponsiveVisibility.screen({
    Key? key,
    required this.child,
    this.visible = true,
    this.conditionScreen = _defaultConditionScreenVisibility,
    this.localBreakpoints,
  })  : type = ConditionType.screen,
        visibleWhen = const [],
        hiddenWhen = const [],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize mutable value holders.
    final bool visibleValue = getVisibilityValue(context);

    return visibleValue ? child : const SizedBox();
  }

  bool getVisibilityValue(BuildContext context) {
    final List<ConditionBreakpoint<bool>> conditions = [];
    bool visibleValue = visible;

    // Combine Conditions.
    conditions.addAll(visibleWhen.map((e) => e.copyWith(value: true)));
    conditions.addAll(hiddenWhen.map((e) => e.copyWith(value: false)));

    if (type! == ConditionType.conditions) {
      visibleValue = valueFromConditionByBreakpoints<bool>(
        context: context,
        condition: conditions,
        localBreakpoints: localBreakpoints,
        defaultValue: visibleValue,
      );
    } else {
      visibleValue = valueFromConditionByScreen<bool>(
        context: context,
        condition: conditionScreen,
        localBreakpoints: localBreakpoints,
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
