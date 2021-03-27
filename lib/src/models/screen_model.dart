abstract class ScreenModel<T> {
  final T? mobile;
  final T? tablet;
  final T? desktop;

  const ScreenModel({
    this.mobile,
    this.tablet,
    this.desktop,
  });

  ScreenModel copyWith();

  @override
  String toString() => 'mobile: $mobile, tablet: $tablet, desktop: $desktop';
}
