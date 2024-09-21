import 'package:flutter/widgets.dart';

import 'responsive_information.dart';

/// Signature for the `builder` function which takes the `BuildContext` and
/// [ResponsiveInformation] and is responsible for returning a widget which is to be rendered.
typedef RBuilder = Widget Function(BuildContext ctx, ResponsiveInformation info);

/// Signature for the `builder` function which takes the `BuildContext` and
/// [T?] and is match conditions for the [ConditionalResponsiveWidget].
typedef CBuilder<T> = Widget Function(BuildContext ctx, T match);

/// Signature for the `measure` widget callback
typedef OnWidgetSizeChange = void Function(Size size);
