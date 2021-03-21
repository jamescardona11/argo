class ScreenBreakpoints {
  final double mobile;
  final double tablet;
  final double desktop;

  const ScreenBreakpoints({
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  @override
  String toString() {
    return "Desktop: $desktop, Tablet: $tablet, Mobile: $mobile";
  }
}
