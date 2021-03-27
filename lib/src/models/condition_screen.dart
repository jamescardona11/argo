import 'condition.dart';

class ConditionScreen<T> extends Condition<T> {
  const ConditionScreen({
    T? mobile,
    T? tablet,
    T? desktop,
  })  : assert(mobile != null || tablet != null || desktop != null),
        super(mobile: mobile, tablet: tablet, desktop: desktop);

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
