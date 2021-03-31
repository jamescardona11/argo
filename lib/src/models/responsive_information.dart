import 'package:flutter/widgets.dart';

import 'device_screen.dart';
import 'screen_breakpoints.dart';

class ResponsiveInformation {
  final DeviceScreen deviceScreenType;
  final Size screenSize;
  final Size localSize;
  final ScreenBreakpoints currentBreakpoints;
  final bool isLandscape;
  final bool isPortrait;

  ResponsiveInformation({
    required this.deviceScreenType,
    required this.screenSize,
    required this.localSize,
    required this.currentBreakpoints,
    required Orientation orientation,
  })   : isLandscape = orientation == Orientation.landscape,
        isPortrait = orientation == Orientation.portrait;

  bool get isMobile => deviceScreenType.isMobile();
  bool get isTablet => deviceScreenType.isTablet();
  bool get isDesktop => deviceScreenType.isDesktop();

  @override
  String toString() =>
      'DeviceType:$deviceScreenType +ScreenSize:$screenSize LocalSize:$localSize currentBreakpoints: $currentBreakpoints isLandScape: $isLandscape isPortrait: $isPortrait';
}
