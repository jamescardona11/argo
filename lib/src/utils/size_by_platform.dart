import 'package:argo/src/platform_info/platform_info.dart';
import 'package:flutter/widgets.dart';

/// {@template size_by_platform}
///
/// Gets the Width Size by platform,
///
///
/// This method checks if the [ResponsiveWrapper] requires the `width` through the `shortestSide`.
/// The `shortestSide` serves when the device are in landscape mode don't be confuse with a `tablet` screen
///
/// {@endtemplate}
double getSizeByPlatform(Size size) {
  if (PlatformInfo.isWeb) {
    return size.width;
  }

  return size.shortestSide;
}
