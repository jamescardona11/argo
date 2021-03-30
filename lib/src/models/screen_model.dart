import 'dart:ui';

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

  @override
  bool operator ==(Object other) =>
      other is ScreenModel &&
      other.mobile == mobile &&
      other.tablet == tablet &&
      other.desktop == desktop;

  @override
  int get hashCode => hashValues(mobile.hashCode, tablet.hashCode, desktop.hashCode);
}
