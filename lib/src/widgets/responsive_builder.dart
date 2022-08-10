import 'package:flutter/widgets.dart';

import 'package:argo/src/models/models.dart';
import 'package:argo/src/utils/utils.dart';

/// {@template responsive_builder}
///
/// Widget to build a responsive view.
/// This widget calculates internally [ResponsiveInformation]
///
/// ```dart
/// ResponsiveBuilder(
///   builder: (ctx, info) {
///     ...
///   }
/// )
/// ```
///
/// {@endtemplate}

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    Key? key,
    required this.builder,
    this.breakpoints,
  }) : super(key: key);

  /// Returns [RBuilder] with the responsive information
  final RBuilder builder;

  /// Are the local breakpoints for the widget
  final ScreenBreakpoints? breakpoints;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, boxConstraints) {
      final info = getResponsiveInformation(
        context: context,
        localSize: Size(boxConstraints.maxWidth, boxConstraints.maxHeight),
        localBreakpoints: breakpoints,
      );

      return builder(context, info);
    });
  }
}
