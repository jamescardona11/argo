import 'package:flutter/widgets.dart';

import 'package:argo/src/platform_info/platform_info.dart';

/// {@template size_by_platform}
///
/// Gets the Width Size by platform,
///
///
/// This method checks if the [ResponsiveWrapper] requires the `width` through the `shortestSide`.
/// The `shortestSide` serves when the device are in landscape mode don't be confuse with a `tablet` screen
///
/// {@endtemplate}
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
