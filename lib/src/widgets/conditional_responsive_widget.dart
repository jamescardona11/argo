import 'package:flutter/widgets.dart';

import '../models/condition.dart';
import '../models/condition_breakpoint.dart';
import '../models/condition_screen.dart';
import '../models/screen_breakpoints.dart';
import '../models/typedef.dart';
import '../utils/get_condition_breakpoint.dart';

/// {@template conditional_responsive_widget}
///
/// Widget to do something if conditionalMatch a `builder` depending of the [Condition].
/// You can use [ConditionScreen] or [ConditionBreakpoint] each one will bring you a different control
///
/// {@endtemplate}

class ConditionalResponsiveWidget<T> extends StatelessWidget {
  const ConditionalResponsiveWidget({
    Key? key,
    required this.builder,
    this.conditionsMatch = const [],
    this.localBreakpoints,
  }) : super(key: key);

  /// Returns [CBuilder] with the value match
  final CBuilder<T?> builder;

  /// List of conditions to show when they are met [ConditionBreakpoint]
  final List<ConditionBreakpoint<T>> conditionsMatch;

  /// Are the local breakpoints for the widget
  final ScreenBreakpoints? localBreakpoints;

  @override
  Widget build(BuildContext context) {
    // Initialize mutable value holders.
    final value = valueFromConditionByBreakpoints<T>(
      context: context,
      condition: conditionsMatch,
      localBreakpoints: localBreakpoints,
    );

    return builder(context, value);
  }
}
