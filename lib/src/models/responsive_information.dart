import 'package:flutter/widgets.dart';

import 'device_screen.dart';

class ResponsiveInformation {
  final DeviceScreenType deviceScreenType;
  final Size screenSize;
  final Size localSize;

  ResponsiveInformation({
    required this.deviceScreenType,
    required this.screenSize,
    required this.localSize,
  });

  bool get isMobile => deviceScreenType.isMobile();
  bool get isTablet => deviceScreenType.isTablet();
  bool get isDesktop => deviceScreenType.isDesktop();

  @override
  String toString() =>
      'DeviceType:$deviceScreenType ScreenSize:$screenSize LocalSize:$localSize';
}
