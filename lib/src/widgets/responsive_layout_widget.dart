import 'package:flutter/widgets.dart';

import '../models/device_screen.dart';
import '../models/screen_breakpoints.dart';
import '../utils/get_current_breakpoints.dart';

/// Widget to show diferents childs depends of situation, you can use LocalBreakpoints, GlobalBreakpoints or DefaultBreakpoints
/// [Mobile], [tablet], [desktop] are widget children
/// [ScreenBreakpoints] property is LocalBreakpoints for this widgets
class ResponsiveLayoutWidget extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  final ScreenBreakpoints? breakpoints;

  const ResponsiveLayoutWidget({
    Key? key,
    this.mobile = const SizedBox(),
    this.tablet,
    this.desktop,
    this.breakpoints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bp = getCurrentBreakPoints(context: context, local: breakpoints);
        final size = MediaQuery.of(context).size;

        final deviceScreenType = DeviceScreenTypeX.fromBreakpoint(size, bp);

        if (deviceScreenType.isDesktop()) {
          // If we have supplied the desktop layout then display that
          if (desktop != null) return desktop!;
          // If no desktop layout is supplied we want to check if we have the size below it and display that
          if (tablet != null) return tablet!;
        }

        if (deviceScreenType.isTablet()) {
          if (tablet != null) return tablet!;
        }

        // If none of the layouts above are supplied or we're on the mobile layout then we show the mobile layout
        return mobile;
      },
    );
  }
}
