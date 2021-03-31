import '../models/typedef.dart';
import '../utils/get_resonsive_information.dart';
import 'package:flutter/widgets.dart';

import '../models/device_screen.dart';
import '../models/responsive_information.dart';
import '../models/screen_breakpoints.dart';
import '../utils/get_current_breakpoints.dart';

/// Widget to build a responsive view, this widget return [ResponsiveInformation]
/// [ScreenBreakpoints] property is LocalBreakpoints for this widgets
class ResponsiveBuilder extends StatelessWidget {
  final RBuilder builder;
  final ScreenBreakpoints? breakpoints;

  const ResponsiveBuilder({
    Key? key,
    required this.builder,
    this.breakpoints,
  }) : super(key: key);

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
