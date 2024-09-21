import 'package:argo/src/models/models.dart';
import 'package:argo/src/utils/get_responsive_information.dart';
import 'package:flutter/widgets.dart';

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
    super.key,
    required this.builder,
    this.localBreakpoints,
  });

  /// Returns [RBuilder] with the responsive information
  final RBuilder builder;

  /// Are the local breakpoints for the widget
  final ScreenBreakpoints? localBreakpoints;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, boxConstraints) {
      final info = getResponsiveInformation(
        context: context,
        localSize: Size(boxConstraints.maxWidth, boxConstraints.maxHeight),
        localBreakpoints: localBreakpoints,
      );

      return builder(context, info);
    });
  }
}
