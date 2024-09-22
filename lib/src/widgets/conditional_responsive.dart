import 'dart:async';

import 'package:argo/src/models/models.dart';
import 'package:argo/src/utils/get_condition_breakpoint.dart';
import 'package:flutter/widgets.dart';

/// {@template conditional_responsive_widget}
///
/// Widget to do something if conditionalMatch a `builder` depending of the [Condition].
/// You can use [ConditionScreen] or [ConditionBreakpoint] each one will bring you a different control
///
/// {@endtemplate}

class ConditionalResponsive<T> extends StatefulWidget {
  const ConditionalResponsive({
    super.key,
    required Widget child,
    this.listener,
    this.conditions = const [],
    this.localBreakpoints,
  })  : builder = null,
        child = child;

  const ConditionalResponsive.builder({
    super.key,
    required CBuilder<T?> builder,
    this.listener,
    this.conditions = const [],
    this.localBreakpoints,
  })  : builder = builder,
        child = null;

  /// Returns [CBuilder] with the value match
  final CBuilder<T?>? builder;

  final Widget? child;

  /// Returns [CListener] with the value match
  final CListener<T?>? listener;

  /// List of conditions to show when they are met [ConditionBreakpoint]
  final List<ConditionBreakpoint<T>> conditions;

  /// Are the local breakpoints for the widget
  final ScreenBreakpoints? localBreakpoints;

  @override
  State<ConditionalResponsive<T>> createState() => _ConditionalResponsiveState<T>();
}

class _ConditionalResponsiveState<T> extends State<ConditionalResponsive<T>> {
  StreamSubscription<ConditionBreakpoint<T>?>? _subscription;
  final _streamController = StreamController<ConditionBreakpoint<T>?>();
  List<ConditionBreakpoint<T>> _conditions = [];
  ScreenBreakpoints? _localBreakpoints;

  @override
  void initState() {
    super.initState();
    _conditions = widget.conditions;
    _localBreakpoints = widget.localBreakpoints;

    _subscribe();
  }

  @override
  void didUpdateWidget(covariant ConditionalResponsive<T> oldWidget) {
    if (oldWidget.conditions != widget.conditions || oldWidget.localBreakpoints != widget.localBreakpoints) {
      _conditions = widget.conditions;
      _localBreakpoints = widget.localBreakpoints;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    // Initialize mutable value holders.
    final value = GetConditionBreakpoint<T>().value(
      context: context,
      size: size,
      conditions: _conditions,
      localBreakpoints: _localBreakpoints,
    );
    _streamController.add(value);

    if (widget.builder == null) return widget.child!;

    return widget.builder!(value);
  }

  @override
  void dispose() {
    _unsubscribe();
    _streamController.close();
    super.dispose();
  }

  void _subscribe() {
    if (widget.listener == null) return;
    _subscription = _streamController.stream.listen((match) {
      widget.listener?.call(match);
    });
  }

  void _unsubscribe() {
    _subscription?.cancel();
  }
}
