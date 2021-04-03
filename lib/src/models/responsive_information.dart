import 'package:flutter/widgets.dart';

import 'device_screen.dart';
import 'screen_breakpoints.dart';

/// {@template responsive_information}
///
/// Data class to handle `responsive` information for the widget
/// This class stores the necesary information so the widget can create their `responsive`
///
/// {@endtemplate}
class ResponsiveInformation {
  ResponsiveInformation({
    required this.deviceScreen,
    required this.screenSize,
    required this.localSize,
    required this.currentBreakpoints,
    required Orientation orientation,
  })   : isLandscape = orientation == Orientation.landscape,
        isPortrait = orientation == Orientation.portrait;

  /// This value tells the condition to look for the `breakpoint` value in the [WrapperConfig]
  /// for the sreen type `mobile`, `tablet`, `desktop`

  final DeviceScreen deviceScreen;

  /// `Size` of the current `screen`
  /// This is similar to `MediaQuery.of(context).size`
  final Size screenSize;

  /// `Size` of the current `Widget`
  /// This value it is obtained by the constraints
  final Size localSize;

  /// They are the actual control points after filter between all the `Breakpoints`
  /// `LocalBreakpoints`, `GlobalBreakpoints` or `DefaultBreakpoints`
  final ScreenBreakpoints currentBreakpoints;

  /// Return true if the de device is mode Landscape
  final bool isLandscape;

  /// Return true if the de device is mode Portrait
  final bool isPortrait;

  bool get isMobile => deviceScreen.isMobile();
  bool get isTablet => deviceScreen.isTablet();
  bool get isDesktop => deviceScreen.isDesktop();

  @override
  String toString() =>
      'DeviceType:$deviceScreen ScreenSize:$screenSize LocalSize:$localSize currentBreakpoints: $currentBreakpoints isLandScape: $isLandscape isPortrait: $isPortrait';
}
