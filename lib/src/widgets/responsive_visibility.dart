import 'package:argo/src/models/models.dart';
import 'package:argo/src/utils/utils.dart';
import 'package:flutter/widgets.dart';

/// {@template responsive_visibility}
///
/// Widget to show or hide a `child` depending of the [Condition].
/// You can use [ConditionScreen] or [ConditionBreakpoint] each one will bring you a different control
///
/// {@endtemplate}

class ResponsiveVisibility extends StatelessWidget {
  const ResponsiveVisibility.byConditions({
    super.key,
    required this.child,
    this.defaultVisibility = false,
    this.visibleWhen = const [],
    this.hiddenWhen = const [],
    this.localBreakpoints,
  }) : conditionScreen = null;

  const ResponsiveVisibility.byScreen({
    super.key,
    required this.child,
    required ConditionScreen<bool> conditionScreen,
    this.defaultVisibility = false,
    this.localBreakpoints,
  })  : conditionScreen = conditionScreen,
        visibleWhen = const [],
        hiddenWhen = const [];

  /// The widget to show or hide
  final Widget child;

  /// List of conditions to hide when they are met [ConditionBreakpoint]
  final List<ConditionBreakpoint<bool>> hiddenWhen;

  /// List of conditions to show when they are met [ConditionBreakpoint]
  final List<ConditionBreakpoint<bool>> visibleWhen;

  /// Do the manage of the visibility by [ConditionScreen]
  final ConditionScreen<bool>? conditionScreen;

  /// The default value visibility of the widget when the conditions are not met
  final bool defaultVisibility;

  /// Are the local breakpoints for the widget
  final ScreenBreakpoints? localBreakpoints;

  @override
  Widget build(BuildContext context) {
    bool? visibleValue;
    final size = MediaQuery.sizeOf(context);

    if (conditionScreen == null) {
      // Combine Conditions.
      final List<ConditionBreakpoint<bool>> conditions = [];
      conditions.addAll(visibleWhen.map((e) => e.copyWith(value: true)));
      conditions.addAll(hiddenWhen.map((e) => e.copyWith(value: false)));

      visibleValue = GetConditionBreakpoint<bool>().value(
        context: context,
        size: size,
        conditions: conditions,
        localBreakpoints: localBreakpoints,
      );
    } else {
      visibleValue = GetConditionScreen<bool>().value(
        context: context,
        size: size,
        condition: conditionScreen!,
        localBreakpoints: localBreakpoints,
      );
    }

    return Visibility(
      visible: visibleValue ?? defaultVisibility,
      child: child,
    );
  }
}
