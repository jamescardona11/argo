import 'condition.dart';

/// {@template condition_screen}
///
/// Child class of [Condition],
/// It's goal is to have conditional value for the tree screen types [mobile], [tablet], [desktop].
/// For default the [Conditional] always will be `EQUALS`,
/// `ConditionScreen` will be use by [valueFromConditionByScreen]
///
/// T Mobile: Is the value when the app screen is `mobile` this value is getting from CurrentBreakpoint (Local, Global or Default)
/// T Tablet: Is the value when the app screen is `tablet` this value is getting from CurrentBreakpoint (Local, Global or Default)
/// T Desktop: Is the value when the app screen is `desktop` this value is getting from CurrentBreakpoint (Local, Global or Default)
///
/// CurrentBreakpoint is gets from method [getCurrentBreakPoints]
///
/// Example
/// ```dart
/// ConditionScreen(
///  mobile: 'Mobile',
///  tablet: 'Tablet',
///  desktop: 'Desktop',
/// );
/// ```
///
/// {@endtemplate}
class ConditionScreen<T> extends Condition<T> {
  const ConditionScreen({
    super.mobile,
    super.tablet,
    super.desktop,
  }) : assert(mobile != null || tablet != null || desktop != null);

  @override
  ConditionScreen copyWith({
    T? mobile,
    T? tablet,
    T? desktop,
  }) =>
      ConditionScreen(
        mobile: mobile ?? this.mobile,
        tablet: tablet ?? this.tablet,
        desktop: desktop ?? this.desktop,
      );

  @override
  String toString() => 'ConditionScreen( ${super.toString()})';
}
