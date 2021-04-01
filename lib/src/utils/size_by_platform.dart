import 'package:flutter/widgets.dart';

import '../platform_info/platform_info.dart';

/// Get Width Size by platform and check if the globalconfiguration need the shortestside
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
