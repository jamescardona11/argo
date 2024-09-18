/// {@template screen_model}
///
/// Parent class that has the structure of the `conditions` and the `breakpoints`
///
/// {@endtemplate}
abstract class ScreenModel<T> {
  const ScreenModel({
    this.mobile,
    this.tablet,
    this.desktop,
  });

  /// Value for mobile `Screen`
  final T? mobile;

  /// Value for tablet `Screen`
  final T? tablet;

  /// Value for desktop `Screen`
  final T? desktop;

  ScreenModel copyWith();

  @override
  String toString() => 'mobile: $mobile, tablet: $tablet, desktop: $desktop';

  @override
  bool operator ==(Object other) => other is ScreenModel && other.mobile == mobile && other.tablet == tablet && other.desktop == desktop;

  @override
  int get hashCode => Object.hash(mobile.hashCode, tablet.hashCode, desktop.hashCode);
}
