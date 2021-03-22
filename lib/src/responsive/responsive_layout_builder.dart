import 'package:argo/src/responsive/responsive_wrapper.dart';
import 'package:argo/src/utils/device_screen_type.dart';
import 'package:argo/src/utils/screen_breakpoints.dart';
import 'package:flutter/widgets.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  final ScreenBreakpoints? breakpoints;

  ResponsiveWidget({
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
        final bp = getBreakPoints(context, breakpoints);
        final size = MediaQuery.of(context).size;

        final deviceScreenType = DeviceScreenTypeX.getDeviceType(size, bp);

        if (deviceScreenType == DeviceScreenType.desktop) {
          // If we have supplied the desktop layout then display that
          if (desktop != null) return desktop!;
          // If no desktop layout is supplied we want to check if we have the size below it and display that
          if (tablet != null) return tablet!;
        }

        if (deviceScreenType == DeviceScreenType.tablet) {
          if (tablet != null) return tablet!;
        }

        // If none of the layouts above are supplied or we're on the mobile layout then we show the mobile layout
        return mobile;
      },
    );
  }

  ScreenBreakpoints getBreakPoints(BuildContext context, ScreenBreakpoints? local) {
    final rw = ResponsiveWrapper.of(context);
    ScreenBreakpoints? globalBreakpoints = rw?.globalBreakpoints;

    return defaultBreakPoints.copyWith(
      mobile: local != null ? local.mobile : globalBreakpoints?.mobile,
      tablet: local != null ? local.tablet : globalBreakpoints?.tablet,
      desktop: local != null ? local.desktop : globalBreakpoints?.tablet,
    );
  }
}
