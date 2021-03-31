import 'package:flutter/widgets.dart';

import '../platform_info/platform_info.dart';

double getSizeByPlatform(Size size, {bool shortestSide = false}) {
  if (shortestSide) {
    double deviceWidth = size.shortestSide;
    if (PlatformInfo.isWeb) {
      deviceWidth = size.width;
    }

    return deviceWidth;
  }

  return size.width;
}
