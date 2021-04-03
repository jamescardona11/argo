import 'package:flutter/widgets.dart';

import '../models/responsive_information.dart';
import '../models/screen_breakpoints.dart';
import '../models/typedef.dart';
import '../utils/get_resonsive_information.dart';

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
