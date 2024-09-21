import 'package:argo/src/models/models.dart';
import 'package:argo/src/utils/get_condition_breakpoint.dart';
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
    final size = MediaQuery.sizeOf(context);

    // Initialize mutable value holders.
    final value = GetConditionBreakpoint<T>().value(
      context: context,
      size: size,
      conditions: conditionsMatch,
      localBreakpoints: localBreakpoints,
    );

    return builder(context, value);
  }
}
