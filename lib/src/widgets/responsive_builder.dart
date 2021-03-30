import '../models/device_screen.dart';
import '../models/responsive_information.dart';
import '../models/screen_breakpoints.dart';
import '../utils/get_current_breakpoints.dart';
import 'package:flutter/widgets.dart';

typedef RBuilder = Widget Function(BuildContext context, ResponsiveInformation info);

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
      final bp = getCurrentBreakPoints(context: context, local: breakpoints);
      final size = MediaQuery.of(context).size;

      var info = ResponsiveInformation(
        deviceScreenType: DeviceScreenTypeX.fromBreakpoint(size, bp),
        screenSize: size,
        localSize: Size(boxConstraints.maxWidth, boxConstraints.maxHeight),
      );
      return builder(context, info);
    });
  }
}
