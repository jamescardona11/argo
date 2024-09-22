import 'package:argo/argo.dart';
import 'package:flutter/widgets.dart';

/// Signature for the `builder` function which takes the `BuildContext` and
/// [ResponsiveInformation] and is responsible for returning a widget which is to be rendered.
typedef RBuilder = Widget Function(BuildContext ctx, ResponsiveInformation info);

/// Signature for the `builder` function which takes the `BuildContext` and
/// [T?] and is match conditions for the [ConditionalResponsiveWidget].
typedef CBuilder<T> = Widget Function(ConditionBreakpoint<T>? condition);

typedef CListener<T> = void Function(ConditionBreakpoint<T>? condition);

/// Signature for the `measure` widget callback
typedef OnWidgetSizeChange = void Function(Size size);
