import 'package:argo/src/extensions/responsive_extension.dart';
import 'package:argo/src/models/device_screen.dart';
import 'package:argo/src/models/screen_breakpoints.dart';
import 'package:argo/src/utils/utils.dart';
import 'package:argo/src/widgets/responsive_wrapper.dart';
import 'package:flutter/material.dart';

/// {@template responsive_extension}
///
/// Extension to bring the information in a easier way for the responsive.
/// All calculations related whit `MediaQuery.of(context).size`
///
/// ```dart
/// context.isLandscape;
/// context.widthPct(10);
/// context.heightPx;
/// ...
/// ```
///
/// {@endtemplate}
extension DeviceContext on BuildContext {
  bool isMobile() => _getDeviceScreen().isMobile();
  bool isTablet() => _getDeviceScreen().isTablet();
  bool isDesktop() => _getDeviceScreen().isDesktop();

  DeviceScreen _getDeviceScreen() {
    final ScreenBreakpoints globalBreakpoints = ResponsiveWrapper.getGlobalBreakpoints(this);
    return DeviceScreenX.fromBreakpoint(getSizeByPlatform(sizePx), globalBreakpoints);
  }
}
