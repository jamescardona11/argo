import 'package:argo/src/utils/device_screen_type.dart';
import 'package:flutter/widgets.dart';

class SizingInformation {
  final DeviceScreenType deviceScreenType;
  final Size screenSize;
  final Size localSize;

  SizingInformation({
    required this.deviceScreenType,
    required this.screenSize,
    required this.localSize,
  });

  bool get isMobile => deviceScreenType == DeviceScreenType.mobile;
  bool get isTablet => deviceScreenType == DeviceScreenType.tablet;
  bool get isDesktop => deviceScreenType == DeviceScreenType.desktop;

  @override
  String toString() {
    return 'DeviceType:$deviceScreenType ScreenSize:$screenSize LocalSize:$localSize';
  }
}
