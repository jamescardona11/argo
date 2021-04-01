import 'package:flutter/widgets.dart';

import 'device_screen.dart';
import 'screen_breakpoints.dart';

class ResponsiveInformation {
  final DeviceScreen deviceScreen;
  final Size screenSize;
  final Size localSize;
  final ScreenBreakpoints currentBreakpoints;
  final bool isLandscape;
  final bool isPortrait;

  ResponsiveInformation({
    required this.deviceScreen,
    required this.screenSize,
    required this.localSize,
    required this.currentBreakpoints,
    required Orientation orientation,
  })   : isLandscape = orientation == Orientation.landscape,
        isPortrait = orientation == Orientation.portrait;

  bool get isMobile => deviceScreen.isMobile();
  bool get isTablet => deviceScreen.isTablet();
  bool get isDesktop => deviceScreen.isDesktop();

  @override
  String toString() =>
      'DeviceType:$deviceScreen +ScreenSize:$screenSize LocalSize:$localSize currentBreakpoints: $currentBreakpoints isLandScape: $isLandscape isPortrait: $isPortrait';
}
