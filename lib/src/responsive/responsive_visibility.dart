import 'package:argo/src/utils/condition.dart';
import 'package:argo/src/utils/screen_breakpoints.dart';
import 'package:flutter/widgets.dart';

class ResponsiveVisibility extends StatelessWidget {
  final Widget child;
  final bool visible;
  final List<Condition> visibleWhen;
  final List<Condition> hiddenWhen;
  final Widget replacement;
  final bool maintainState;
  final bool maintainAnimation;
  final bool maintainSize;
  final bool maintainSemantics;
  final bool maintainInteractivity;
  final ScreenBreakpoints? breakpoints;

  const ResponsiveVisibility({
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize mutable value holders.
    List<Condition> conditions = [];
    bool visibleValue = visible;

    // Combine Conditions.
    conditions.addAll(visibleWhen.map((e) => e.copyWith(value: true)));
    conditions.addAll(hiddenWhen.map((e) => e.copyWith(value: false)));
    final bp = getBreakPoints(context, breakpoints);

    // Get visible value from active condition.
    // visibleValue =
    //     ResponsiveValue(context, defaultValue: visibleValue, valueWhen: conditions).value;

    return LayoutBuilder(
      builder: (context, constraints) {
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
      },
    );
  }
}
