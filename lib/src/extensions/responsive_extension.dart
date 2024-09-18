import 'dart:math';

import 'package:argo/src/platform_info/platform_info.dart';
import 'package:flutter/material.dart';

/// {@template responsive_extension}
///
/// Extension to bring the information in a easier way for the responsive.
/// All calculations related whit `MediaQuery`
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
  /// Returns if Orientation is landscape
  bool get isLandscape => MediaQuery.orientationOf(this) == Orientation.landscape;

  /// Returns same as MediaQuery.of(context).size
  Size get sizePx => MediaQuery.sizeOf(this);

  /// Returns same as MediaQuery.of(context).size.width
  double get widthPx => sizePx.width;

  /// Returns same as MediaQuery.of(context).height
  double get heightPx => sizePx.height;

  /// Returns diagonal screen pixels
  double get diagonalPx {
    final size = MediaQuery.sizeOf(this);
    return sqrt((size.width * size.width) + (size.height * size.height));
  }

  /// Returns pixel size in Inches
  Size get sizeInches {
    final Size size = MediaQuery.sizeOf(this);
    return Size(size.width / _pixelsPerInch, size.height / _pixelsPerInch);
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

  double get _pixelsPerInch => PlatformInfo.isAndroid || PlatformInfo.isIOS ? 150 : 96;
}
