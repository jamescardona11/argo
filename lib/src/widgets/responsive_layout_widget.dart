import 'package:argo/src/models/responsive_information.dart';
import 'package:argo/src/utils/get_responsive_information.dart';
import 'package:flutter/widgets.dart';

import '../models/screen_breakpoints.dart';
import '../models/typedef.dart';

/// {@template responsive_layout_widget}
///
/// Widget that shows different children depending of `screen` type,
/// the screen was set from [ResponsiveWrapper] using `globalBreakpoints`,
/// and you can override the globalBreakpoints for localBreakpoints.
///
/// ```dart
/// ResponsiveLayoutWidget(
///   mobile: MobileChild(),
///   tablet: TabletChild(),
///   desktop: DesktopChild(),
/// )
/// ```
///
/// Also you can use the constructor `ResponsiveLayoutWidget.builder`,
/// to return for each `child` the [ResponsiveInformation]
///
/// ```dart
/// ResponsiveLayoutWidget.builder(
///   mobile: (ctx, info) => MobileChild(),
///   tablet: (ctx, info) => TabletChild(),
///   desktop:(ctx, info) => DesktopChild(),
/// )
/// ```
///
/// {@endtemplate}

class ResponsiveLayoutWidget extends StatelessWidget {
  const ResponsiveLayoutWidget({
    super.key,
    Widget mobile = const SizedBox(),
    Widget? tablet,
    Widget? desktop,
    this.breakpoints,
  })  : mobile = mobile,
        tablet = tablet,
        desktop = desktop;

  const ResponsiveLayoutWidget.builder({
    super.key,
    RBuilder? mobile,
    RBuilder? tablet,
    RBuilder? desktop,
    this.breakpoints,
  })  : mobile = mobile,
        tablet = tablet,
        desktop = desktop;

  /// This value may be type `Widget` or `RBuilder`
  final dynamic mobile;

  /// This value may be type `Widget` or `RBuilder`
  final dynamic tablet;

  /// This value may be type `Widget` or `RBuilder`
  final dynamic desktop;

  /// Are the local breakpoints for the widget
  final ScreenBreakpoints? breakpoints;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints boxConstraints) {
        final info = GetResponsiveInformation().value(
          context: context,
          screenSize: size,
          localSize: Size(boxConstraints.maxWidth, boxConstraints.maxHeight),
          localBreakpoints: breakpoints,
        );

        if (info.isDesktop) {
          // If we have supplied the desktop layout then display that
          if (desktop != null) return _returnValue(desktop, context, info);
          // If no desktop layout is supplied we want to check if we have the size below it and display that
          if (tablet != null) return _returnValue(tablet, context, info);
        }

        if (info.deviceScreen.isTablet()) {
          if (tablet != null) return _returnValue(tablet, context, info);
        }

        // If none of the layouts above are supplied or we're on the mobile layout then we show the mobile layout
        return mobile != null ? _returnValue(mobile, context, info) : const SizedBox();
      },
    );
  }

  bool _isRBuilder(dynamic data) => data is RBuilder;

  Widget _returnValue(dynamic data, BuildContext context, ResponsiveInformation info) {
    if (_isRBuilder(data)) {
      return (data as RBuilder)(context, info);
    }

    return data as Widget;
  }
}
