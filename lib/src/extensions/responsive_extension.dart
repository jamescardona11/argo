import 'dart:math';

import 'package:flutter/material.dart';

import 'package:argo/src/models/device_screen.dart';
import 'package:argo/src/models/wrapper_config.dart';
import 'package:argo/src/platform_info/platform_info.dart';
import 'package:argo/src/widgets/responsive_wrapper.dart';

/// {@template responsive_extension}
///
/// Extension to bring the information in a easier way for the responsive.
/// All calculations related whit `MediaQuery.of(context).size`
///
/// ```dart
/// context.isLandscape;
/// context.widthPct(10);
/// context.heightPx;
/// ...
/// ```
///
/// {@endtemplate}
extension ResponsiveContext on BuildContext {
  /// Returns same as MediaQuery.of(context)
  MediaQueryData get mq => responsiveUtils.mq;

  /// Returns if Orientation is landscape
  bool get isLandscape => responsiveUtils.isLandscape;

  /// Returns same as MediaQuery.of(context).size
  Size get sizePx => responsiveUtils.sizePx;

  /// Returns same as MediaQuery.of(context).size.width
  double get widthPx => responsiveUtils.widthPx;

  /// Returns same as MediaQuery.of(context).height
  double get heightPx => responsiveUtils.heightPx;

  /// Returns diagonal screen pixels
  double get diagonalPx => responsiveUtils.diagonalPx;

  /// Returns pixel size in Inches
  Size get sizeInches => responsiveUtils.sizeInches;

  /// Returns screen width in Inches
  double get widthInches => responsiveUtils.widthInches;

  /// Returns screen height in Inches
  double get heightInches => responsiveUtils.heightInches;

  /// Returns screen diagonal in Inches
  double get diagonalInches => responsiveUtils.diagonalInches;

  /// Returns percent (1-100) of screen width in pixels
  double widthPct(double percent) => responsiveUtils.widthPct(percent);

  /// Returns percent (1-100) of screen height in pixels
  double heightPct(double percent) => responsiveUtils.heightPct(percent);

  /// Returns percent (1-100) of screen inches
  double inchesPct(double percent) => responsiveUtils.inchesPct(percent);

  /// Extension for getting Theme
  ThemeData get theme => Theme.of(this);

  /// Extension for getting textTheme
  TextTheme get textTheme => Theme.of(this).textTheme;

  ResponsiveUtils get responsiveUtils => ResponsiveUtils._(this);

  bool isMobile() => responsiveUtils.isMobile();
  bool isTablet() => responsiveUtils.isTablet();
  bool isDesktop() => responsiveUtils.isDesktop();
}

/// {@template responsive_utils}
///
/// This class is a middleware to save the responsive information,
/// it is useful when you have to do a lot of callings in the same file.
/// It has the same behavior as the `BuildContext` extension
///
/// ```dart
/// final mResponsive = ResponsiveUtils.of(context);
///
/// mResponsive.isLandscape;
/// mResponsive.widthPct(10);
/// mResponsive.heightPx;
/// ...
/// ```
///
/// {@endtemplate}
class ResponsiveUtils {
  final BuildContext _context;

  double get _pixelsPerInch =>
      PlatformInfo.isAndroid || PlatformInfo.isIOS ? 150 : 96;

  /// Returns same as MediaQuery.of(context)
  MediaQueryData get mq => MediaQuery.of(_context);

  /// Returns if Orientation is landscape
  bool get isLandscape => mq.orientation == Orientation.landscape;

  /// Returns same as MediaQuery.of(context).size
  Size get sizePx => mq.size;

  /// Returns same as MediaQuery.of(context).size.width
  double get widthPx => sizePx.width;

  /// Returns same as MediaQuery.of(context).height
  double get heightPx => sizePx.height;

  double get topPadding => mq.padding.top;

  double get appBarHeight => topPadding + kToolbarHeight;

  /// Returns diagonal screen pixels
  double get diagonalPx {
    final Size s = sizePx;
    return sqrt((s.width * s.width) + (s.height * s.height));
  }

  /// Returns pixel size in Inches
  Size get sizeInches {
    final Size pxSize = sizePx;
    return Size(pxSize.width / _pixelsPerInch, pxSize.height / _pixelsPerInch);
  }

  /// Returns screen width in Inches
  double get widthInches => sizeInches.width;

  /// Returns screen height in Inches
  double get heightInches => sizeInches.height;

  /// Returns screen diagonal in Inches
  double get diagonalInches => diagonalPx / _pixelsPerInch;

  /// Returns percent (1-100) of screen width in pixels
  double widthPct(double percent) => percent * widthPx / 100;

  /// Returns percent (1-100) of screen height in pixels
  double heightPct(double percent) => percent * heightPx / 100;

  /// Returns percent (1-100) of screen inches
  double inchesPct(double percent) => percent * diagonalInches / 100;

  /// Extension for getting Theme
  ThemeData get theme => Theme.of(_context);

  /// Extension for getting textTheme
  TextTheme get textTheme => Theme.of(_context).textTheme;

  bool isMobile() => _getDeviceScreen(_context).isMobile();
  bool isTablet() => _getDeviceScreen(_context).isTablet();
  bool isDesktop() => _getDeviceScreen(_context).isDesktop();

  WrapperConfig get _rw => ResponsiveWrapper.getWrapperConfig(_context);
  DeviceScreen _getDeviceScreen(BuildContext context) {
    return DeviceScreenX.fromBreakpoint(
        _rw.getDeviceWidth(MediaQuery.of(context).size), _rw.globalBreakpoints);
  }

  //Private constructor
  ResponsiveUtils._(this._context);

  //Public constructor
  ResponsiveUtils.of(this._context);
}
