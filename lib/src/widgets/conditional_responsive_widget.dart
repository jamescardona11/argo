import 'package:argo/src/models/models.dart';
import 'package:argo/src/utils/utils.dart';
import 'package:flutter/widgets.dart';

/// {@template conditional_responsive_widget}
///
/// Widget to do something if conditionalMatch a `builder` depending of the [Condition].
/// You can use [ConditionScreen] or [ConditionBreakpoint] each one will bring you a different control
///
/// {@endtemplate}

class ConditionalResponsiveWidget<T> extends StatelessWidget {
  const ConditionalResponsiveWidget({
    super.key,
    required this.builder,
    this.conditionsMatch = const [],
    this.localBreakpoints,
  });

  /// Returns [CBuilder] with the value match
  final CBuilder<T?> builder;

  /// List of conditions to show when they are met [ConditionBreakpoint]
  final List<ConditionBreakpoint<T>> conditionsMatch;

  /// Are the local breakpoints for the widget
  final ScreenBreakpoints? localBreakpoints;

  @override
  Widget build(BuildContext context) {
    // Initialize mutable value holders.
    final value = valueFromConditionByBreakpointsFunc<T>(
      context: context,
      condition: conditionsMatch,
      localBreakpoints: localBreakpoints,
    );

    return builder(context, value);
  }
}
