import 'screen_model.dart';

class ScreenBreakpoints extends ScreenModel<double> {
  const ScreenBreakpoints({
    required double mobile,
    required double tablet,
    required double desktop,
  }) : super(mobile: mobile, tablet: tablet, desktop: desktop);

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
  String toString() => 'ScreenBreakpoints(${super.toString()})';
}

// Minimum values breakpoints for type of device
const defaultBreakPoints = const ScreenBreakpoints(
  mobile: 320,
  tablet: 700,
  desktop: 1200,
);
