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
  const ResponsiveVisibility.conditions({
    super.key,
    required this.child,
    this.visibilityIfNotMatch,
    this.visibleWhen = const [],
    this.hiddenWhen = const [],
    this.localBreakpoints,
  })  : assert(visibleWhen.length == 0 || hiddenWhen.length == 0),
        type = ConditionType.conditions,
        conditionScreen = _defaultConditionScreenVisibility;

  const ResponsiveVisibility.screen({
    super.key,
    required this.child,
    this.visibilityIfNotMatch = false,
    this.conditionScreen = _defaultConditionScreenVisibility,
    this.localBreakpoints,
  })  : type = ConditionType.screen,
        visibleWhen = const [],
        hiddenWhen = const [];

  /// The widget to show or hide
  final Widget child;

  /// List of conditions to hide when they are met [ConditionBreakpoint]
  final List<ConditionBreakpoint<bool>> hiddenWhen;

  /// List of conditions to show when they are met [ConditionBreakpoint]
  final List<ConditionBreakpoint<bool>> visibleWhen;

  /// Do the manage of the visibility by [ConditionScreen]
  final ConditionScreen<bool> conditionScreen;

  /// the default value visibility of the widget
  final bool? visibilityIfNotMatch;

  /// Are the local breakpoints for the widget
  final ScreenBreakpoints? localBreakpoints;

  /// The type of conditions that was invoked
  final ConditionType? type;

  @override
  Widget build(BuildContext context) {
    // Initialize mutable value holders.
    final bool visibleValue = getVisibilityValue(context);

    return Visibility(
      visible: visibleValue,
      child: child,
    );
  }

  bool getVisibilityValue(BuildContext context) {
    final List<ConditionBreakpoint<bool>> conditions = [];
    bool visibleValue = visibilityIfNotMatch != null ? visibilityIfNotMatch! : visibleWhen.isEmpty;

    // Combine Conditions.
    conditions.addAll(visibleWhen.map((e) => e.copyWith(value: true)));
    conditions.addAll(hiddenWhen.map((e) => e.copyWith(value: false)));

    if (type! == ConditionType.conditions) {
      visibleValue = ArgoUtils.valueFromConditionByBreakpoints<bool>(
        context: context,
        condition: conditions,
        localBreakpoints: localBreakpoints,
        defaultValue: visibleValue,
      )!;
    } else {
      visibleValue = ArgoUtils.valueFromConditionByScreen<bool>(
        context: context,
        condition: conditionScreen,
        localBreakpoints: localBreakpoints,
        defaultValue: visibleValue,
      )!;
    }

    return visibleValue;
  }
}

const _defaultConditionScreenVisibility = ConditionScreen<bool>(
  mobile: true,
  tablet: false,
  desktop: false,
);
