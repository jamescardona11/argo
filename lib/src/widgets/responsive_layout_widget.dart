import 'package:argo/src/models/responsive_information.dart';
import 'package:flutter/widgets.dart';

import '../models/device_screen.dart';
import '../models/screen_breakpoints.dart';
import '../models/typedef.dart';
import '../utils/get_resonsive_information.dart';

/// Widget to show diferents childs depends of situation, you can use LocalBreakpoints, GlobalBreakpoints or DefaultBreakpoints
/// [Mobile], [tablet], [desktop] are widget children
/// [ScreenBreakpoints] property is LocalBreakpoints for this widgets
class ResponsiveLayoutWidget extends StatelessWidget {
  final dynamic? mobile;
  final dynamic? tablet;
  final dynamic? desktop;
  final ScreenBreakpoints? breakpoints;

  const ResponsiveLayoutWidget({
    Key? key,
    Widget mobile = const SizedBox(),
    Widget? tablet,
    Widget? desktop,
    this.breakpoints,
  })  : mobile = mobile,
        tablet = tablet,
        desktop = desktop,
        super(key: key);

  const ResponsiveLayoutWidget.builder({
    Key? key,
    RBuilder? mobile,
    RBuilder? tablet,
    RBuilder? desktop,
    this.breakpoints,
  })  : mobile = mobile,
        tablet = tablet,
        desktop = desktop,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints boxConstraints) {
        final info = getResponsiveInformation(
          context: context,
          localSize: Size(boxConstraints.maxWidth, boxConstraints.maxHeight),
          localBreakpoints: breakpoints,
        );

        if (info.deviceScreen.isDesktop()) {
          // If we have supplied the desktop layout then display that
          if (desktop != null) return returnValue(desktop, context, info);
          // If no desktop layout is supplied we want to check if we have the size below it and display that
          if (tablet != null) return returnValue(tablet, context, info);
        }

        if (info.deviceScreen.isTablet()) {
          if (tablet != null) return returnValue(tablet, context, info);
        }

        // If none of the layouts above are supplied or we're on the mobile layout then we show the mobile layout
        return mobile != null ? returnValue(mobile, context, info) : const SizedBox();
      },
    );
  }

  bool _isRBuilder(dynamic data) => data is RBuilder;

  Widget returnValue(dynamic data, BuildContext context, ResponsiveInformation info) {
    if (_isRBuilder(data)) {
      return (data as RBuilder)(context, info);
    }

    return data as Widget;
  }
}
