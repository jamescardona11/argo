import 'dart:math';

import 'package:flutter/widgets.dart';
import '../platform_info/platform_info.dart';

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

  ResponsiveUtils get responsiveUtils => ResponsiveUtils._(this);
}

class ResponsiveUtils {
  final BuildContext _context;

  ResponsiveUtils._(this._context);

  double get _pixelsPerInch => PlatformInfo.isAndroid || PlatformInfo.isIOS ? 150 : 96;

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
}
