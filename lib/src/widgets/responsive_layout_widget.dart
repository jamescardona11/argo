import 'package:flutter/widgets.dart';

import '../models/device_screen.dart';
import '../models/screen_breakpoints.dart';
import '../models/typedef.dart';
import '../utils/get_resonsive_information.dart';

/// Widget to show diferents childs depends of situation, you can use LocalBreakpoints, GlobalBreakpoints or DefaultBreakpoints
/// [Mobile], [tablet], [desktop] are widget children
/// [ScreenBreakpoints] property is LocalBreakpoints for this widgets
class ResponsiveLayoutWidget extends StatelessWidget {
  final RBuilder? mobile;
  final RBuilder? tablet;
  final RBuilder? desktop;
  final ScreenBreakpoints? breakpoints;

  const ResponsiveLayoutWidget({
    Key? key,
    this.mobile,
    this.tablet,
    this.desktop,
    this.breakpoints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints boxConstraints) {
        final info = getResponsiveInformation(
          context: context,
          localSize: Size(boxConstraints.maxWidth, boxConstraints.maxHeight),
          localBreakpoints: breakpoints,
        );

        if (info.deviceScreenType.isDesktop()) {
          // If we have supplied the desktop layout then display that
          if (desktop != null) return desktop!(context, info);
          // If no desktop layout is supplied we want to check if we have the size below it and display that
          if (tablet != null) return tablet!(context, info);
        }

        if (info.deviceScreenType.isTablet()) {
          if (tablet != null) return tablet!(context, info);
        }

        // If none of the layouts above are supplied or we're on the mobile layout then we show the mobile layout
        return mobile != null ? mobile!(context, info) : const SizedBox();
      },
    );
  }
}
