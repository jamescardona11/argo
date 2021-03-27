import 'package:flutter/widgets.dart';

import '../platform_info/platform_info.dart';

double getSizeByPlatform(Size size) {
  double deviceWidth = size.shortestSide;
  if (PlatformInfo.isWeb) {
    deviceWidth = size.width;
  }

  return deviceWidth;
}
