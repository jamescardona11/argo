import 'screen_model.dart';

//Minimum Values for Mobile, Tablet, Desktop
class ScreenBreakpoints extends ScreenModel<double> {
  final bool isFloor;

  const ScreenBreakpoints({
    required double mobile,
    required double tablet,
    required double desktop,
  })   : isFloor = true,
        super(mobile: mobile, tablet: tablet, desktop: desktop);

  const ScreenBreakpoints.byFloor({
    required double mobile,
    required double tablet,
    required double desktop,
  })   : isFloor = true,
        super(mobile: mobile, tablet: tablet, desktop: desktop);

  const ScreenBreakpoints.byCeiling({
    required double mobile,
    required double tablet,
    required double desktop,
  })   : isFloor = false,
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
const defaultBreakPoints = const ScreenBreakpoints(
  mobile: 320,
  tablet: 700,
  desktop: 1200,
);
