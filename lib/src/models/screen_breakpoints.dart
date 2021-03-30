import 'screen_model.dart';

class ScreenBreakpoints extends ScreenModel<double> {
  final bool isFloor;

  /// When the need to call [getCurrentBreakPoints]
  /// the null values set from globalValue
  /// if global.value == null set from [defaultBreakPoints]
  const ScreenBreakpoints({
    double? mobile,
    double? tablet,
    double? desktop,
  })  : isFloor = true,
        super(mobile: mobile, tablet: tablet, desktop: desktop);

  /// The values was compared by Minimum values from [mobile], [tablet], [desktop]
  /// Ex: Mobile minimum value 320 from [defaultBreakPoints]
  const ScreenBreakpoints.byFloor({
    double? mobile,
    double? tablet,
    double? desktop,
  })  : isFloor = true,
        super(mobile: mobile, tablet: tablet, desktop: desktop);

  /// The values was compared by Maximun values from [mobile], [tablet], [desktop]
  /// Ex: Mobile maximun value 700 from ScreenBreakpoints( mobile: 700, tablet: 1100, desktop: 4000)
  const ScreenBreakpoints.byCeiling({
    double? mobile,
    double? tablet,
    double? desktop,
  })  : isFloor = false,
        super(mobile: mobile, tablet: tablet, desktop: desktop);

  @override
  ScreenBreakpoints copyWith({
    double? mobile,
    double? tablet,
    double? desktop,
  }) =>
      ScreenBreakpoints(
        mobile: mobile ?? defaultBreakPoints.mobile!,
        tablet: tablet ?? defaultBreakPoints.tablet!,
        desktop: desktop ?? defaultBreakPoints.desktop!,
      );

  @override
  String toString() => 'ScreenBreakpoints(${super.toString()} isFloor: $isFloor)';
}

// Minimum values breakpoints for type of device
const defaultBreakPoints = ScreenBreakpoints(
  mobile: 320,
  tablet: 700,
  desktop: 1200,
);
