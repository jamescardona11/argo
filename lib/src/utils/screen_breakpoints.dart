// Minimum values breakpoints for type of device

class ScreenBreakpoints {
  final double mobile;
  final double tablet;
  final double desktop;

  const ScreenBreakpoints({
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  ScreenBreakpoints copyWith({
    double? mobile,
    double? tablet,
    double? desktop,
  }) =>
      ScreenBreakpoints(
        mobile: mobile ?? defaultBreakPoints.mobile,
        tablet: tablet ?? defaultBreakPoints.tablet,
        desktop: desktop ?? defaultBreakPoints.desktop,
      );

  @override
  String toString() {
    return "Desktop: $desktop, Tablet: $tablet, Mobile: $mobile";
  }
}

// Minimum values breakpoints for type of device
const ScreenBreakpoints defaultBreakPoints = const ScreenBreakpoints(
  mobile: 320,
  tablet: 700,
  desktop: 1200,
);

class RefinedBreakpoints {
  // Desktop
  final double desktopExtraLarge = 4096;
  final double desktopLarge = 3840;
  final double desktopNormal = 1920;
  final double desktopSmall = 950;
  // Tablet
  final double tabletExtraLarge = 900;
  final double tabletLarge = 850;
  final double tabletNormal = 768;
  final double tabletSmall = 650;
  // Mobile
  final double mobileExtraLarge = 480;
  final double mobileLarge = 414;
  final double mobileNormal = 375;
  final double mobileSmall = 320;
}
