import '../platform_info/platform_info.dart';
import 'package:flutter/widgets.dart';

double getSizeByPlatform(Size size) {
  double deviceWidth = size.shortestSide;
  if (PlatformInfo.isWeb) {
    deviceWidth = size.width;
  }

  return deviceWidth;
}
